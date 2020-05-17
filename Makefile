build:
		@docker build --tag sineverba/cfhookbash --file ./docker/Dockerfile .

run:
		@docker run -it --rm -v ${PWD}/docker/app/config:/config -v ${PWD}/docker/app/certs:/certs --name cfhookbash sineverba/cfhookbash

test:
		docker run -dit -v ${PWD}/docker/app/config:/config -v ${PWD}/docker/app/certs:/certs --name cfhookbash --entrypoint=/bin/sh sineverba/cfhookbash
		docker exec -it cfhookbash cat /dehydrated/dehydrated | grep 0.6.5
		docker container stop cfhookbash
		docker container rm cfhookbash

inspect:
		docker run -it --entrypoint "/bin/bash" --rm -v ${PWD}/docker/app/config:/config -v ${PWD}/docker/app/certs:/certs --name cfhookbash sineverba/cfhookbash

destroy:
		docker image rm sineverba/cfhookbash:latest