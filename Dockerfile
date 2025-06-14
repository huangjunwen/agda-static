FROM debian:11.11

RUN apt-get update && \
    apt-get install -y curl git cabal-install pkg-config patch zlib1g-dev libncurses5-dev upx && \
    cabal update 

WORKDIR /root

COPY envs /root/envs

COPY patches /root/patches

ARG AGDA_VER

RUN . /root/envs/env-$AGDA_VER && \
    mkdir -p /root/agda-libs && \
        cd /root/agda-libs && \
        curl -L -o stdlib.tar.gz https://github.com/agda/agda-stdlib/archive/refs/tags/$AGDA_STDLIB_VER.tar.gz && \
        tar xfz stdlib.tar.gz && \
        rm stdlib.tar.gz && \
    git clone -b $AGDA_VER --depth 1 https://github.com/agda/agda.git /root/agda && \
        cd /root/agda && \
        patch -p1 < /root/patches/Agda-$AGDA_VER.patch && \
        cabal install --enable-split-objs -O2  --install-method=copy && \
        upx /root/.cabal/bin/agda && \
        upx /root/.cabal/bin/agda-mode

##############################################

FROM bash:5.2

COPY bin/.                               /agda-static/bin
COPY --from=0 /root/.cabal/bin/.         /agda-static/bin/agda-static
COPY --from=0 /root/agda/src/data/.      /agda-static/share/agda/data
COPY --from=0 /root/agda-libs/.          /agda-static/share/agda/libs

# Test, also gen libraries/defaults files
RUN /agda-static/bin/agda --print-agda-data-dir && \
    /agda-static/bin/agda --print-agda-app-dir

ENV PATH /agda-static/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/agda-static/bin/agda"]
