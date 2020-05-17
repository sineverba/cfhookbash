#!/bin/sh

docker tag ${DOCKER_USERNAME}/${DOCKER_IMAGE} ${DOCKER_USERNAME}/${DOCKER_IMAGE}:latest
docker tag ${DOCKER_USERNAME}/${DOCKER_IMAGE} ${DOCKER_USERNAME}/${DOCKER_IMAGE}:${TRAVIS_TAG}

echo "$DOCKER_API_KEY" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push ${DOCKER_USERNAME}/${DOCKER_IMAGE}:latest;
docker push ${DOCKER_USERNAME}/${DOCKER_IMAGE}:$TRAVIS_TAG;

# Microbadger webhook
curl -n -X POST https://hooks.microbadger.com/images/${DOCKER_USERNAME}/${DOCKER_IMAGE}/${MICROBADGER_KEY}