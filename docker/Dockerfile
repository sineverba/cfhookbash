FROM alpine:3.15.0

RUN apk update && apk upgrade && apk add --no-cache bash curl jq openssl --upgrade grep

RUN mkdir -p dehydrated /app/dehydrated

COPY docker/dehydrated/ /dehydrated/
RUN chmod +x /dehydrated/dehydrated

COPY ./hook.sh /dehydrated
COPY ./config.default.sh /dehydrated/config.sh

COPY docker/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]