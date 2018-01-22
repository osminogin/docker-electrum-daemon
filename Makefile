ELECTRUM_VERSION = $(strip $(shell cat VERSION))

DOCKER_IMAGE ?= osminogin/electrum-daemon
DOCKER_TAG = ELECTRUM_VERSION

default: docker_build

docker_build:
	@docker build \
		--build-arg VERSION=$(ELECTRUM_VERSION) \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		-t $(DOCKER_IMAGE):$(DOCKER_TAG) .
