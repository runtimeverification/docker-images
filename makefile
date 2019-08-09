build-%:
	docker-compose build --pull $*

push-%:
	$(eval IMG := $(shell echo $* | sed -e "s/\(^[^-]*\).*/\1/"))
	$(eval TAG := $(shell echo $* | sed -e "s/^[^-]*-\(.*\)/\1/"))
	$(eval NEW_IMGTAG := runtimeverificationinc/$(IMG):$(TAG))
	docker tag $(IMG):$(TAG) $(NEW_IMGTAG)
	docker push $(NEW_IMGTAG)

%:
	$(MAKE) build-$@
	$(MAKE) push-$@
