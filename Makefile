COMMIT := $(shell git rev-parse --short=8 HEAD)
IMAGE := email-oauth2-proxy

ifeq ($(CI)x, x)
	TAG := local
else
	TAG := $(COMMIT)
endif

help:  ## Print the help documentation
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: docker
docker: ## Builds Docker Image
	docker build -f docker/Dockerfile docker/ -t $(IMAGE):$(TAG)

.PHONY: helm
helm: ## Packages Helm Chart
	helm package charts/email-oauth2-proxy --destination .cr-release-packages
	helm repo index ./.cr-release-packages --url https://pjaudiomv.github.io/email-oauth2-proxy/
