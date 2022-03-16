FROM docker.io/tiredofit/alpine:3.15
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV COTURN_VERSION=4.5.2

### Build Dependencies
RUN set -x && \
    addgroup -g 3478 coturn && \
    adduser --disabled-password --system --home /var/lib/coturn --shell /sbin/nologin -u 3478 --ingroup coturn coturn && \
    apk update && \
    apk upgrade && \
    apk add -t .coturn-build-deps \
        build-base \
        coreutils \
        autoconf \
        g++ \
        hiredis-dev \
        libevent-dev \
        libtool \
        linux-headers \
        mariadb-connector-c-dev \
        mongo-c-driver-dev \
        libressl-dev \
        postgresql-dev \
        sqlite-dev \
        && \
    \
### Run Depedencies
    apk add -t .coturn-run-deps \
        hiredis \
        libcrypto1.1 \
        libevent \
        libpq \
        libssl1.1 \
        libstdc++ \
        mariadb-connector-c \
        mongo-c-driver \
        libressl \
        sqlite \
        sqlite-libs \
        && \
    \
### Compile Coturn
    mkdir -p /usr/src/coturn && \
    curl -ssL https://github.com/coturn/coturn/archive/${COTURN_VERSION}.tar.gz | tar xvfz - --strip 1 -C /usr/src/coturn && \
    cd /usr/src/coturn && \
    ./configure --prefix=/usr \
        --turndbdir=/data \
        --disable-rpath \
        --sysconfdir=/etc/coturn \
        --mandir=/tmp/coturn/man \
        --docsdir=/tmp/coturn/docs \
        --examplesdir=/tmp/coturn/examples \
        && \
    make && \
    make install &&\
    make clean && \
    \
### Cleanup
    apk del .coturn-build-deps && \
    rm -rf /usr/src /var/cache/apk

### Networking Configuration
EXPOSE 443 3478 3478/udp 3479/udp 5349 5350

### Files Addition
ADD install /
