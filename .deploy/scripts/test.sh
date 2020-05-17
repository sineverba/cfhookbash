#!/bin/sh

set -e
docker run -dit \
    -v /docker/app/config:/config \
    -v /docker/app/dehydrated:/dehydrated \
    -v /docker/app/certs:/certs --name ${DOCKER_IMAGE} \
    --entrypoint=/bin/sh ${DOCKER_USERNAME}/${DOCKER_IMAGE}
docker exec -it ${DOCKER_IMAGE} cat /dehydrated/dehydrated | grep 0.6.5
docker inspect -f {{.Config.Labels}} ${DOCKER_IMAGE} | grep $VCS_REF
docker container stop ${DOCKER_IMAGE}
docker container rm ${DOCKER_IMAGE}