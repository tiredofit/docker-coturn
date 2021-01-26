# hub.docker.com/tiredofit/coturn

## Introduction

This will build a container for [coturn](https://github.com/coturn/coturn). A STUN and TURN server for WebRTC and other media
applications allowing for NAT traversal.

* Compiles from Source with SQLite and Redis Support

This Container uses [tiredofit:alpine:3.7](https://hub.docker.com/r/tiredofit/alpine) as a base.

[Changelog](CHANGELOG.md)

## Authors

- [Dave Conroy] [https://github.com/tiredofit]

## Table of Contents

- [hub.docker.com/tiredofit/coturn](#hubdockercomtiredofitcoturn)
- [Introduction](#introduction)
- [Authors](#authors)
- [Table of Contents](#table-of-contents)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data-Volumes](#data-volumes)
    - [Environment Variables](#environment-variables)
    - [Networking](#networking)
- [Maintenance](#maintenance)
      - [Shell Access](#shell-access)
- [References](#references)

## Prerequisites

## Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/tiredofit/coturn) and is the recommended method of installation.

```bash
docker pull hub.docker.com/tiredofit/coturn
```

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Make [networking ports](#networking) available for public access if necessary

## Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory         | Description                                  |
| ----------------- | -------------------------------------------- |
| `/data`           | Coturn Database and TLS Certs should go here |
| `/var/log/coturn` | Logfiles for coturn                          |

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), below is the complete list of available options that can be used to customize your installation.

| Parameter | Description |
| --------- | ----------- |

### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |

## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. coturn) bash
```

## References

* <https://github.com/coturn/coturn>
