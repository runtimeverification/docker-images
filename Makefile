UBUNTU_PATTERNS := ubuntu-FLAVOR-rv

UBUNTU_BIONIC_IMAGES := $(patsubst FLAVOR,bionic,$(UBUNTU_PATTERNS))
UBUNTU_XENIAL_IMAGES := $(patsubst FLAVOR,xenial,$(UBUNTU_PATTERNS))

.PHONY: $(UBUNTU_BIONIC_IMAGES) $(UBUNTU_XENIAL_IMAGES)

ubuntu-%-rv:
	# Build the image.
	docker-compose build --pull $@
	# Push to the public registry on dockerhub.
	docker push runtimeverificationinc/ubuntu:$*
