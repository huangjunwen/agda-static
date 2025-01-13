FROM i386/debian:11.11

RUN apt-get update && \
    apt-get install -y cabal-install pkg-config patch zlib1g-dev libncurses5-dev strip upx && \
    cabal update 

WORKDIR /root

COPY patches /root/patches

ARG AGDA_VER=2.6.4.3
ARG PREFIX=/usr/local

RUN cabal get Agda-$AGDA_VER && \
    cd Agda-$AGDA_VER && \
    patch -p1 < /root/patches/Agda-$AGDA_VER.patch && \
    cabal install --enable-split-objs --bindir=$PREFIX/bin --libdir=$PREFIX/lib --datadir=$PREFIX/share
