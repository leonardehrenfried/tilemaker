FROM debian:buster-slim
LABEL Description="Tilemaker" Version="1.4.0"

ARG DEBIAN_FRONTEND=noninteractive

ENV BUILD_DEPENDENCIES build-essential liblua5.1-0-dev protobuf-compiler libboost-system-dev
ENV RUNTIME_DEPENDENCIES liblua5.1-0 libprotobuf-dev libsqlite3-dev shapelib libshp-dev libboost-program-options-dev libboost-filesystem-dev libboost-system1.67.0

COPY . /
WORKDIR /

# install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends $BUILD_DEPENDENCIES $RUNTIME_DEPENDENCIES && \
    make && \
    make install && \
    # clean up, remove build-time only dependencies
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove $BUILD_DEPENDENCIES &&

ENTRYPOINT ["tilemaker"]
