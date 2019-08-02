build-%:
	docker-compose build --pull $*

push-%:
	$(eval IMG := $(shell echo $* | sed -e "s/\(^[^-]*\).*/\1/"))
	$(eval TAG := $(shell echo $* | sed -e "s/^[^-]*-\(.*\)/\1/"))
	docker push runtimeverificationinc/$(IMG):$(TAG)

%:
	$(MAKE) build-$@
	$(MAKE) push-$@
