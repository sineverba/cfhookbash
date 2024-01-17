IMAGE_NAME=sineverba/cfhookbash
CONTAINER_NAME=cfhookbash
APP_VERSION=4.9.0-dev
BUILDX_VERSION=0.12.1
BINFMT_VERSION=qemu-v7.0.0-28


build:
	docker build --tag $(IMAGE_NAME):$(APP_VERSION) --file ./docker/Dockerfile .

preparemulti:
	mkdir -vp ~/.docker/cli-plugins
	curl -L "https://github.com/docker/buildx/releases/download/v$(BUILDX_VERSION)/buildx-v$(BUILDX_VERSION).linux-amd64" > ~/.docker/cli-plugins/docker-buildx
	chmod a+x ~/.docker/cli-plugins/docker-buildx
	docker buildx version
	docker run --rm --privileged tonistiigi/binfmt:$(BINFMT_VERSION) --install all
	docker buildx ls
	docker buildx rm multiarch
	docker buildx create --name multiarch --driver docker-container --use
	
multi:
	docker buildx inspect --bootstrap --builder multiarch
	docker buildx build --platform linux/arm64/v8,linux/amd64,linux/arm/v6,linux/arm/v7 --tag $(IMAGE_NAME):$(APP_VERSION) --tag $(IMAGE_NAME):latest --file ./docker/Dockerfile .

test:
	docker run --rm -it --entrypoint cat --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION) /etc/os-release | grep "Alpine Linux v3.19"
	docker run --rm -it --entrypoint cat --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION) /etc/os-release | grep "3.19.0"
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION) | grep "INFO: Using main config file /app/dehydrated/config"
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION) | grep "Registering account"
	docker run -it --rm --entrypoint dehydrated/dehydrated --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION) --version | grep "Dehydrated version: 0.7.2"

spin:
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION)

inspect:
	docker run -it --entrypoint "/bin/bash" --rm --name $(CONTAINER_NAME) $(IMAGE_NAME):$(APP_VERSION)

destroy:
	docker image rm alpine:3.19.0
	docker image rm $(IMAGE_NAME):$(APP_VERSION)