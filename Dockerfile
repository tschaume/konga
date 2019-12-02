FROM node:10.16-alpine

RUN apk upgrade --update \
    && apk add bash git ca-certificates \
    && npm config set unsafe-perm true \
    && npm install -g bower \
    && npm config delete python

COPY . /app

WORKDIR /app

RUN npm --unsafe-perm --production install \
    && apk del git \
    && rm -rf /var/cache/apk/* \
        /app/.git \
        /app/screenshots \
        /app/test

COPY kong_node.data /app/kong_node.data
COPY userdb.data /app/userdb.data

VOLUME /app/kongadata

EXPOSE 1337

ENTRYPOINT ["/app/start.sh"]
