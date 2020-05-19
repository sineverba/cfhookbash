#!/bin/sh

set -e

docker run -dit \
    -v ${TRAVIS_BUILD_DIR}/certs:/certs \
    -v ${TRAVIS_BUILD_DIR}/config:/config \
    --name ${DOCKER_IMAGE} \
    --entrypoint=/bin/sh ${DOCKER_USERNAME}/${DOCKER_IMAGE}
docker exec -it ${DOCKER_IMAGE} cat /dehydrated/dehydrated | grep 0.6.5
docker inspect -f {{.Config.Labels}} ${DOCKER_IMAGE} | grep $VCS_REF
docker container stop ${DOCKER_IMAGE}
docker container rm ${DOCKER_IMAGE}