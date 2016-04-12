CURRENT_DIRECTORY := $(shell pwd)
include environment

build:
	sed -i.bak 's|^FROM.*|FROM $(DOCKER_OPENJRE)|' Dockerfile && \
	docker build --build-arg ELASTIC_VERSION=$(ELASTIC_VERSION) --build-arg ELASTIC_DOWNLOAD_URL=$(ELASTIC_DOWNLOAD_URL) -t $(DOCKER_USER)/elastic --rm=true . && \
	mv Dockerfile.bak Dockerfile

debug:
	docker run -it -v $(REPO_WORKING_DIR)/config:/usr/share/elasticsearch/config -v /tmp/elastic:/usr/share/elasticsearch/data -p 9200:9200 -p 9300:9300 --entrypoint=sh $(DOCKER_USER)/elastic

run:
	docker run -d --name elastic -v $(REPO_WORKING_DIR)/config:/usr/share/elasticsearch/config -v /tmp/elastic:/usr/share/elasticsearch/data -p 9200:9200 -p 9300:9300 $(DOCKER_USER)/elastic
