FROM alpine:3.7

# Alpine doesn't ship with Bash.
RUN apk add --no-cache bash

# Install Unison from source with inotify support + remove compilation tools
ARG UNISON_VERSION=2.51.2
RUN apk add --no-cache --virtual .build-dependencies build-base curl && \
    apk add --no-cache inotify-tools ocaml && \
    curl -L https://github.com/bcpierce00/unison/archive/v$UNISON_VERSION.tar.gz | tar zxv -C /tmp && \
    cd /tmp/unison-${UNISON_VERSION} && \
    sed -i -e 's/GLIBC_SUPPORT_INOTIFY 0/GLIBC_SUPPORT_INOTIFY 1/' src/fsmonitor/linux/inotify_stubs.c && \
    make UISTYLE=text NATIVE=true STATIC=true && \
    cp src/unison src/unison-fsmonitor /usr/local/bin && \
    apk del .build-dependencies ocaml && \
    rm -rf /tmp/unison-${UNISON_VERSION}

ENV UNISON_USER="root" \
    UNISON_GROUP="root" \
    UNISON_UID="0" \
    UNISON_GID="0" \
    SYNC_SOURCE_BASE_PATH="/sync" \
    SYNC_DESTINATION_BASE_PATH="/var/www/html" \
    SYNC_PREFER="newer" \
    SYNC_SILENT="0" \
    SYNC_MAX_INOTIFY_WATCHES='' \
    SYNC_EXTRA_UNISON_PROFILE_OPTS='' \
    SYNC_NODELETE_SOURCE="0"

COPY entrypoint.sh /entrypoint
COPY sync.sh /usr/local/bin/sync
COPY watch.sh /usr/local/bin/watch

RUN chmod +x /entrypoint /usr/local/bin/sync /usr/local/bin/watch

ENTRYPOINT ["/entrypoint"]
