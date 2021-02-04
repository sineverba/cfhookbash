build:
	docker build --tag sineverba/cfhookbash:latest --build-arg VCS_REF=`git rev-parse --short HEAD` --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` --file ./docker/Dockerfile .

run:
	#docker run -it -v ${PWD}/certs:/certs -v ${PWD}/config:/config --name cfhookbash sineverba/cfhookbash:latest
	docker run -it --rm --name cfhookbash sineverba/cfhookbash:latest

inspect:
	#docker run -it --entrypoint "/bin/bash" -v ${PWD}/certs:/certs -v ${PWD}/config:/config cfhookbash
	docker run -it --entrypoint "/bin/bash" cfhookbash

destroy:
	docker image rm sineverba/cfhookbash:latest