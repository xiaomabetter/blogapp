DOCKER_HUB = harbor.51cashbox.com
DOCKER_TAG = v0.0.1
DOCKER_IMAGE = $(DOCKER_HUB)/51cashbox/blogapp

build:
        @docker build -t $(DOCKER_IMAGE):$(DOCKER_TAG) .

push:
        @docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
all: build push

rm:
        @docker rmi $(DOCKER_IMAGE):$(DOCKER_TAG)
.PHONY: build push all rm
