# Cura Engine 

- [Cura Engine](https://github.com/Ultimaker/CuraEngine) with all depended repos.  

- This repo include:
    - Protobuf
    - libArcus
    - CuraEngine

## Install from Dockerhub

```
$ docker pull serhattsnmz/cura-engine-env
```

## Install with Dockerfile

```
$ git clone https://github.com/serhattsnmz/cura-engine-env.git
$ cd cura-engine-env
$ docker build -t cura-engine-env .
$ docker run -it --name cura-engine cura-engine-env
```

## Install Manualy on Linux 

#### Install Packages

```
$ apt update \
    && apt install -y apt-utils libtool dh-autoreconf \
    && apt install -y cmake python3-dev python3-sip-dev git
```

#### Install Protobuf

```
$ cd cura-engine-env/protobuf-3.6.1/
$ chmod +x ./autogen.sh && ./autogen.sh
$ chmod +x ./configure && ./configure
$ make
$ make install
$ ldconfig
```

#### Install libArcus

```
$ cd cura-engine-env/libArcus-3.6.0/
$ mkdir build
$ cd build
$ cmake ..
$ make
$ make install
```

#### Install CuraEngine

```
$ cd cura-engine-env/CuraEngine-3.6.0/
$ mkdir build
$ cd build
$ cmake ..
$ make
$ make install
```

## Running

> **NOTE**  
> All printer default settings are hosted in `/printer-settings` folder, which is equal to [Cura Definitions Folder](https://github.com/Ultimaker/Cura/tree/master/resources/definitions)

```
WITH DOCKER:
$ docker run --rm serhattsnmz/cura-engine-env \
    CuraEngine slice -v \
    -j /printer-settings/ultimaker3.def.json \
    -o "/test.gcode" \
    -s infill_line_distance=0 \
    -l "/model_1.stl"

ON LINUX:
$ CuraEngine slice -v \
    -j /printer-settings/ultimaker3.def.json \
    -o "/test.gcode" \
    -s infill_line_distance=0 \
    -l "/model_1.stl"
```