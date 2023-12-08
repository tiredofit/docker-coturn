FROM docker.io/tiredofit/alpine:3.19
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV COTURN_VERSION=4.5.2 \
    IMAGE_NAME=tiredofit/coturn \
    IMAGE_REPO_URL=https://github.com/tiredofit/docker-coturn

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
        cmake \
        g++ \
        git \
        hiredis-dev \
        libevent-dev \
        libtool \
        libmicrohttpd-dev \
        linux-headers \
        mariadb-connector-c-dev \
        mongo-c-driver-dev \
        openssl-dev \
        postgresql-dev \
        sqlite-dev \
        && \
    \
### Run Depedencies
    apk add -t .coturn-run-deps \
        hiredis \
        inotify-tools \
        libcrypto1.1 \
        libevent \
        libpq \
        libssl1.1 \
        libstdc++ \
        mariadb-client \
        mariadb-connector-c \
        mongo-c-driver \
        postgresql-client\
        libmicrohttpd \
        openssl \
        sqlite \
        sqlite-libs \
        && \
    \
### Build Prometheus Clients
    git clone https://github.com/digitalocean/prometheus-client-c /usr/src/promclient && \
    cd /usr/src/promclient && \
    git checkout v0.1.3 && \
    cd /usr/src/promclient/prom && \
    TEST=0 cmake -G "Unix Makefiles" \
                 -DCMAKE_INSTALL_PREFIX=/usr \
                 -DCMAKE_SKIP_BUILD_RPATH=TRUE \
                 -DCMAKE_C_FLAGS="-DPROM_LOG_ENABLE -g -O3" \
                 . \
                 && \
    make && \
    make install && \
    \
    cd /usr/src/promclient/promhttp && \
    sed -i 's/\&promhttp_handler/(MHD_AccessHandlerCallback)\&promhttp_handler/' src/promhttp.c && \
    cd /usr/src/promclient/promhttp && \
    TEST=0 cmake -G "Unix Makefiles" \
                 -DCMAKE_INSTALL_PREFIX=/usr \
                 -DCMAKE_SKIP_BUILD_RPATH=TRUE \
                 -DCMAKE_C_FLAGS="-g -O3" \
                 . \
                 && \
        make VERBOSE=1 && \
        make install && \
    \
    ### Compile Coturn
    mkdir -p /usr/src/coturn && \
    curl -ssL https://github.com/coturn/coturn/archive/${COTURN_VERSION}.tar.gz | tar xvfz - --strip 1 -C /usr/src/coturn && \
    cd /usr/src/coturn && \
    ln -s /usr/lib/pkgconfig/libmariadb.pc /usr/lib/pkgconfig/mariadb.pc && \
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
    rm -rf /usr/src/* /var/cache/apk /tmp/*

### Networking Configuration
EXPOSE 443 3478 3478/udp 3479 5349 5350

### Files Addition
COPY install /
