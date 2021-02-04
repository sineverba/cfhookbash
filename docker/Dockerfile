
FROM alpine:3.13.1

ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/sineverba/cfhookbash" \
      org.label-schema.build-date=$BUILD_DATE

RUN apk add --no-cache bash curl jq openssl --upgrade grep

RUN mkdir -p /app/dehydrated \
                /app/hook

COPY docker/dehydrated/ /app/dehydrated/
RUN chmod +x /app/dehydrated/dehydrated

COPY ./hook.sh /app/hook
COPY ./config.default.sh /app/hook/config.sh

COPY docker/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]