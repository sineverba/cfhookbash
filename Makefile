APP_VERSION=4.6.0
BUILDX_VERSION=0.7.1
IMAGE_NAME=sineverba/cfhookbash-dev
CONTAINER_NAME=cfhookbash-dev


build:
	docker build --tag $(IMAGE_NAME):$(APP_VERSION) --file ./docker/Dockerfile .

multi:
	mkdir -vp ~/.docker/cli-plugins/
	curl --silent -L "https://github.com/docker/buildx/releases/download/v$(BUILDX_VERSION)/buildx-v$(BUILDX_VERSION).linux-amd64" > ~/.docker/cli-plugins/docker-buildx
	chmod a+x ~/.docker/cli-plugins/docker-buildx
	docker buildx version
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name alfa && docker buildx use alfa && docker buildx inspect --bootstrap
	docker buildx build --tag $(IMAGE_NAME):latest --tag $(IMAGE_NAME):$(APP_VERSION) --platform linux/amd64,linux/armhf,linux/arm64 --file ./docker/Dockerfile .
	docker buildx rm alfa

run:
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION)

test:
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION) | grep "INFO: Using main config file /app/dehydrated/config"
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION) | grep "Registering account"

inspect:
	docker run -it --entrypoint "/bin/bash" cfhookbash

destroy:
	docker image rm $(IMAGE_NAME):$(APP_VERSION)