
FROM alpine:3.13.1

ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/sineverba/cfhookbash" \
      org.label-schema.build-date=$BUILD_DATE

RUN apk add --no-cache bash curl jq openssl --upgrade grep

RUN mkdir -p dehydrated /app/dehydrated

COPY docker/dehydrated/ /dehydrated/
RUN chmod +x /dehydrated/dehydrated

COPY ./hook.sh /dehydrated
COPY ./config.default.sh /dehydrated/config.sh

COPY docker/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]