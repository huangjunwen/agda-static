# debian 11.11
FROM debian:bullseye-20250630

ARG AGDA_VER
WORKDIR /root

RUN apt-get update && \
    apt-get install -y curl git cabal-install pkg-config patch zlib1g-dev libncurses5-dev && \
    cabal update 

COPY envs /root/envs
COPY patches /root/patches

RUN . /root/envs/env-$AGDA_VER && \
    git clone -b $AGDA_VER --depth 1 https://github.com/agda/agda.git /root/agda && \
    cd /root/agda && \
    patch -p1 < /root/patches/Agda-$AGDA_VER.patch && \
    cabal install --enable-split-objs -O2  --install-method=copy

RUN . /root/envs/env-$AGDA_VER && \
    mkdir -p /root/agda-libs && \
    cd /root/agda-libs && \
    curl -L -o stdlib.tar.gz https://github.com/agda/agda-stdlib/archive/refs/tags/$AGDA_STDLIB_VER.tar.gz && \
    tar xfz stdlib.tar.gz && \
    rm stdlib.tar.gz

##############################################

FROM bash:5.2

ENV PATH /agda-static/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY --from=0 /root/.cabal/bin/agda       /agda-static/bin/agda
COPY --from=0 /root/.cabal/bin/agda-mode  /agda-static/bin/agda-mode
COPY --from=0 /root/agda/src/data/.       /agda-static/share/agda/data
COPY --from=0 /root/agda-libs/.           /agda-static/share/agda/libs
COPY opt/bin/.                            /agda-static/opt/bin

# Gen libraries/defaults files
# RUN /agda-static/opt/bin/agda --print-agda-data-dir && \
#     /agda-static/opt/bin/agda --print-agda-app-dir

CMD ["/agda-static/opt/bin/agda"]
