FROM alpine:3.9.6

ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/sineverba/cfhookbash" \
      org.label-schema.build-date=$BUILD_DATE

RUN apk add --no-cache bash \
                        curl \
                        jq \
                        openssl \
                        --upgrade grep

RUN mkdir -p /config && \
    mkdir -p /dehydrated && \
    mkdir -p /hooks && \
    mkdir -p /certs && \
    mkdir -p /crontab

COPY ./docker/crontab.txt /crontab/crontab.txt
RUN /usr/bin/crontab /crontab/crontab.txt

COPY ./docker/dehydrated /dehydrated
COPY ./hook.sh /hooks

COPY ./docker/dockerfile-start /usr/local/bin

VOLUME [ "/config" "/certs" ]

WORKDIR /dehydrated

CMD ["dockerfile-start"]