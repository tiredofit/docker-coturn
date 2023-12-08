# github.com/tiredofit/docker-coturn

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-coturn?style=flat-square)](https://github.com/tiredofit/docker-coturn/releases/latest)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/coturn.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/coturn/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/coturn.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/coturn/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/libreoffice-online.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/coturn/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/libreoffice-online.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/coturn/)
* * *


## About

This will build a Docker image for [Coturn](https://www.github.com/coturn/coturn/) a TURN and STUN server for challening network environments.
## Maintainer

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [General Usage](#general-usage)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)
- [Maintainer](#maintainer-1)
- [Table of Contents](#table-of-contents-1)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions-1)
- [Installation](#installation-1)
  - [Quick Start](#quick-start-1)
- [Configuration](#configuration-1)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables-1)
  - [Networking](#networking-1)
- [Maintenance](#maintenance-1)
  - [Shell Access](#shell-access-1)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)

## Installation

### Build from Source
- Clone this repository and build the image with `docker build <arguments> (imagename) .`

- If you decide to compile this, it will take quite a few hours even on the fastest computer due to the amount of data required to download to compile. At some stages this image will grow to 30GB before shedding most of it for it's final size.


### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/collabora-online) and is the recommended method of installation.

```bash
docker pull tiredofit/collabora-online:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| LibreOffice version | Collabora Online version | Tag      |
| ------------------- | ------------------------ | -------- |
| `2022`              | `22.05.x`                | `latest` |
| `2022`              | `22.05.x`                | `2.4.0`  |
| `2021`              | `21.11.0`                | `2.3.0`  |
| `6.4.x`             | `6.4.x`                  | `2.1`    |
| `6.4.x`             | `6.4.x`                  | `2.0`    |
| `6.0.x`             | `4.0.x`                  | `1.6`    |
| `5.3.x`             | `3.4.x`                  | `1.1`    |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration
### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.
* Set various [environment variables](#environment-variables) to understand the capabilities of this image. A Sample `docker-compose.yml` is provided that will work right out of the box for most people without any fancy optimizations.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.


| Directory         | Description                                  |
| ----------------- | -------------------------------------------- |
| `/data`           | Coturn Database and TLS Certs should go here |
| `/var/log/coturn` | Logfiles for coturn                          |

### Environment Variables

#### Base Images used

This image relies on a [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |

#### General Usage
### Networking

The following ports are exposed.

| Port   | Description |
| ------ | ----------- |
| `3478` | Coturn      |
| `3479` | Coturn      |
| `5349` | Coturn      |
| `5350` | Coturn      |

* * *
## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

``bash
docker exec -it (whatever your container name is) bash
``
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- [Sponsor me](https://tiredofit.ca/sponsor) personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- [Sponsor me](https://tiredofit.ca/sponsor) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- [Sponsor me](https://tiredofit.ca/sponsor) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.
## References

* <https://github.com/coturn/coturn>



## Maintainer

- [Dave Conroy] [https://github.com/tiredofit]

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [General Usage](#general-usage)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)
- [Maintainer](#maintainer-1)
- [Table of Contents](#table-of-contents-1)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions-1)
- [Installation](#installation-1)
  - [Quick Start](#quick-start-1)
- [Configuration](#configuration-1)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables-1)
  - [Networking](#networking-1)
- [Maintenance](#maintenance-1)
  - [Shell Access](#shell-access-1)

## Prerequisites and Assumptions

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

### Persistent Storage

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

