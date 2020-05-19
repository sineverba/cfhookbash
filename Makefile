build:
		@docker build --tag sineverba/cfhookbash --file ./docker/Dockerfile .

run:
		@docker run -it --rm -v ${PWD}/certs:/certs -v ${PWD}/config:/config --name cfhookbash sineverba/cfhookbash

test:
		docker run -dit -v ${PWD}/certs:/certs -v ${PWD}/config:/config --name cfhookbash --entrypoint=/bin/sh sineverba/cfhookbash
		docker exec -it cfhookbash cat /dehydrated/dehydrated | grep 0.6.5
		docker container stop cfhookbash
		docker container rm cfhookbash

inspect:
		docker run -it --entrypoint "/bin/bash" --rm -v ${PWD}/certs:/certs -v ${PWD}/config:/config --name cfhookbash sineverba/cfhookbash

destroy:
		sudo rm -r certs/*.*.it
		docker image rm sineverba/cfhookbash:latest