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

COPY --from=0 /root/.cabal/bin/. /bin/
COPY --from=0 /root/agda/. /opt/agda/
COPY --from=0 /root/agda-stdlib/. /opt/agda-stdlib/

# https://agda.readthedocs.io/en/latest/tools/package-system.html
# https://wiki.portal.chalmers.se/agda/Libraries/StandardLibrary
RUN mkdir -p /root/.config/agda && \
    echo "/opt/agda-stdlib/standard-library.agda-lib" > /root/.config/agda/libraries && \
    echo "standard-library" > /root/.config/agda/defaults

ENV Agda_datadir=/opt/agda/src/data

CMD ["/bin/agda"]
