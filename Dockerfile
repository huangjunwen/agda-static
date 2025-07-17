FROM bash:5.2.37-alpine3.22

ARG AGDA_VER
ARG AGDA_STDLIB_VER

WORKDIR /root

# env for agda
ENV Agda_datadir=/agda/share/agda/data
ENV AGDA_DIR=/agda/etc/agda
# add to path
ENV PATH=/agda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY image_files/bin/. /agda/bin/

RUN AGDA_VER=$AGDA_VER /agda/bin/download-agda && \
    AGDA_STDLIB_VER=$AGDA_STDLIB_VER /agda/bin/download-agda-stdlib

