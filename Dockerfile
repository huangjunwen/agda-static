FROM debian:11.11

RUN apt-get update && \
    apt-get install -y git cabal-install pkg-config patch zlib1g-dev libncurses5-dev upx && \
    cabal update 

WORKDIR /root

COPY envs /root/envs

COPY patches /root/patches

ARG AGDA_VER

RUN . /root/envs/env-$AGDA_VER && \
    git clone -b $AGDA_VER --depth 1 https://github.com/agda/agda.git /root/agda && \
    git clone -b $AGDA_STDLIB_VER --depth 1 https://github.com/agda/agda-stdlib.git /root/agda-stdlib && \
    cd /root/agda && \
    patch -p1 < /root/patches/Agda-$AGDA_VER.patch && \
    cabal install --enable-split-objs -O2  --install-method=copy

RUN upx /root/.cabal/bin/agda && upx /root/.cabal/bin/agda-mode

##############################################

FROM alpine:3.21

COPY --from=0 /root/.cabal/bin/agda      /agda-static/bin/agda.static
COPY --from=0 /root/.cabal/bin/agda-mode /agda-static/bin/agda-mode.static
COPY bin/agda                            /agda-static/bin/agda
COPY bin/agda-mode                       /agda-static/bin/agda-mode
COPY --from=0 /root/agda/src/data/.      /agda-static/share/agda/data
COPY --from=0 /root/agda-stdlib/.        /agda-static/share/agda/stdlib

# https://agda.readthedocs.io/en/latest/tools/package-system.html
# https://wiki.portal.chalmers.se/agda/Libraries/StandardLibrary
RUN mkdir -p /agda-static/etc && \
    echo "/agda-static/share/agda/stdlib/standard-library.agda-lib" > /agda-static/etc/agda/libraries && \
    echo "standard-library" > /agda-static/etc/agda/defaults

CMD ["/agda-static/bin/agda"]
