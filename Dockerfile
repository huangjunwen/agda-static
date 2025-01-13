#FROM i386/debian:12.8
FROM i386/debian:11.11

RUN apt-get update && \
    apt-get install -y cabal-install pkg-config zlib1g-dev libncurses5-dev && \
    cabal update 

COPY patches /root/patches

ARG AGDA_VER=2.6.4.3

RUN cabal get Agda-$AGDA_VER && \
    cd Agda-$AGDA_VER && \
    patch -p1 < /root/patches/Agda-$AGDA_VER.patch && \
    cabal install --enable-split-objs --install-method=copy --overwrite-policy=always --global
