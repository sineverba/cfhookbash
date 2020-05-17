build:
		@docker build --tag sineverba/cfledns01 --file ./docker/Dockerfile .

run:
		@docker run -it --rm -v ${PWD}/docker/app/config:/config -v ${PWD}/docker/app/dehydrated:/dehydrated -v ${PWD}/docker/app/certs:/certs --name cfledns01 sineverba/cfledns01

test:
		docker run -dit -v ${PWD}/docker/app/config:/config -v ${PWD}/docker/app/dehydrated:/dehydrated -v ${PWD}/docker/app/certs:/certs --name cfledns01 --entrypoint=/bin/sh sineverba/cfledns01
		docker exec -it cfledns01 cat /dehydrated/dehydrated | grep 0.6.5
		docker container stop cfledns01
		docker container rm cfledns01

inspect:
		docker run -it --entrypoint "/bin/bash" --rm -v ${PWD}/docker/app/config:/config -v ${PWD}/docker/app/dehydrated:/dehydrated -v ${PWD}/docker/app/certs:/certs --name cfledns01 sineverba/cfledns01

destroy:
		docker image rm sineverba/cfledns01:latest