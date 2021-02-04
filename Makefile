build:
	docker build --tag sineverba/cfhookbash:latest --file ./docker/Dockerfile .

multi:
	docker buildx build --platform linux/386,linux/amd64,linux/arm/v6,linux/arm/v7 --tag sineverba/cfhookbash:latest --file ./docker/Dockerfile .

run:
	#docker run -it -v ${PWD}/certs:/certs -v ${PWD}/config:/config --name cfhookbash sineverba/cfhookbash:latest
	docker run -it --rm --name cfhookbash sineverba/cfhookbash:latest

test:
	docker run -it --rm --name cfhookbash sineverba/cfhookbash:latest | grep "INFO: Using main config file /app/dehydrated/config"
	docker run -it --rm --name cfhookbash sineverba/cfhookbash:latest | grep "Registering account"

inspect:
	#docker run -it --entrypoint "/bin/bash" -v ${PWD}/certs:/certs -v ${PWD}/config:/config cfhookbash
	docker run -it --entrypoint "/bin/bash" cfhookbash

destroy:
	docker image rm sineverba/cfhookbash:latest