FROM ubuntu:16.04

EXPOSE 8080
ENV PORT 8080
# Install Packages

RUN apt update \
    && apt install -y apt-utils libtool dh-autoreconf \
    && apt install -y cmake python3-dev python3-sip-dev git

# Add Directories


ADD cura-engine/protobuf-3.6.1/ /cura/protobuf
ADD cura-engine/libArcus-3.6.0/ /cura/libArcus
ADD cura-engine/CuraEngine-3.6.0/ /cura/curaEngine
ADD cura-engine/printer-settings/ /printer-settings

# Install Protobuf

WORKDIR /cura/protobuf
RUN chmod +x ./autogen.sh && ./autogen.sh
RUN chmod +x ./configure && ./configure
RUN make
RUN make install
RUN ldconfig

# Install libArcus

RUN mkdir /cura/libArcus/build
WORKDIR /cura/libArcus/build
RUN cmake ..
RUN make
RUN make install

# Install CuraEngine

RUN mkdir /cura/curaEngine/build
WORKDIR /cura/curaEngine/build
RUN cmake ..
RUN make
RUN make install

# install node
RUN apt install curl
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh

# install server
WORKDIR /
ADD /server /server
RUN apt install -y nodejs
ARG CACHE_DATE=2016-01-01
RUN cd server && npm install