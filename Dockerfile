FROM node:10.16-alpine

COPY . /app

WORKDIR /app

RUN apk upgrade --update \
    && apk add bash git ca-certificates \
    && npm install -g bower \
    && npm config delete python \
    && npm --unsafe-perm --production install \
    && apk del git \
    && rm -rf /var/cache/apk/* \
        /app/.git \
        /app/screenshots \
        /app/test

EXPOSE 1337

COPY kong_node.data /app/kong_node.data
COPY userdb.data /app/userdb.data

VOLUME /app/kongadata

ENTRYPOINT ["/app/start.sh"]
