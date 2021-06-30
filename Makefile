.DEFAULT_GOAL := build

export CONTAINER_NAME=quay.io/slauger/vmware-openapi-generator
export CONTAINER_TAG=latest

build:
	docker build --build-arg OPENSHIFT_RELEASE=$(OPENSHIFT_RELEASE) -t $(CONTAINER_NAME):$(CONTAINER_TAG) .

test:
	docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(shell pwd):/src:ro gcr.io/gcp-runtimes/container-structure-test:latest test --image $(CONTAINER_NAME):$(CONTAINER_TAG) --config /src/tests/image.tests.yaml

push:
	docker push $(CONTAINER_NAME):$(CONTAINER_TAG)

run:
	docker run -it --hostname vmware-openapi-generator --mount type=bind,source="$(shell pwd)",target=/workspace $(CONTAINER_NAME):$(CONTAINER_TAG) /bin/bash
