#!/bin/sh

docker build --tag ${DOCKER_USERNAME}/${DOCKER_IMAGE} \
              --build-arg VCS_REF=$VCS_REF \
              --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
              --file ./docker/Dockerfile ".";