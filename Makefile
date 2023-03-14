.DEFAULT_GOAL := run

DUCKDB_VERSION=v0.7.1
IMAGE_NAME := eldarkann/duckdb:$(DUCKDB_VERSION)
LATEST_IMAGE_NAME := eldarkann/duckdb:latest

build:
	@docker build --build-arg DUCKDB_VERSION=$(DUCKDB_VERSION) -t $(IMAGE_NAME) -t $(LATEST_IMAGE_NAME) .

run:
	@docker run --platform linux/amd64 --rm -it $(IMAGE_NAME) duckdb

push: build
	docker push $(IMAGE_NAME)
	docker push $(LATEST_IMAGE_NAME)
