build:
		@docker build --tag sineverba/cfhookbash:latest --build-arg VCS_REF=`git rev-parse --short HEAD` --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` --file ./docker/Dockerfile .

run:
		@docker run -it -v ${PWD}/certs:/certs -v ${PWD}/config:/config --name cfhookbash sineverba/cfhookbash:latest

test:
		docker run -dit -v ${PWD}/certs:/certs -v ${PWD}/config:/config --name cfhookbash --entrypoint=/bin/sh sineverba/cfhookbash:latest
		docker exec -it cfhookbash cat /dehydrated/dehydrated | grep 0.6.5
		docker container stop cfhookbash
		docker container rm cfhookbash

inspect:
		docker run -it --entrypoint "/bin/bash" -v ${PWD}/certs:/certs -v ${PWD}/config:/config cfhookbash

push:
		docker push sineverba/cfhookbash:latest

destroy:
		docker container stop cfhookbash
		docker container rm cfhookbash
		sudo rm -r certs/
		docker image rm sineverba/cfhookbash:latest