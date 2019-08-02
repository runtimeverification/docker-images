UBUNTU_PATTERNS := ubuntu-FLAVOR \
                   rust-1.34.0-llvm-8-ubuntu-FLAVOR \
									 z3-4.6.0-llvm-8-ubuntu-FLAVOR

UBUNTU_BIONIC_IMAGES := $(patsubst FLAVOR,bionic,$(UBUNTU_PATTERNS))
UBUNTU_XENIAL_IMAGES := $(patsubst FLAVOR,xenial,$(UBUNTU_PATTERNS))

.PHONY: $(UBUNTU_BIONIC_IMAGES) $(UBUNTU_XENIAL_IMAGES)

.PHONY: default
default: $(UBUNTU_BIONIC_IMAGES)

ubuntu-%:
	# Build the image.
	docker-compose build --pull $@
	# Push to the public registry on dockerhub.
	docker push runtimeverificationinc/ubuntu:$*

rust-1.34.0-llvm-8-ubuntu-%: ubuntu-%
	# Build the image.
	docker-compose build --pull $@
	# Push to the public registry on dockerhub.
	docker push runtimeverificationinc/rust:1.34.0-llvm-8-ubuntu-$*


z3-4.6.0-llvm-8-ubuntu-%: ubuntu-%
	# Build the image.
	docker-compose build --pull $@
	# Push to the public registry on dockerhub.
	docker push runtimeverificationinc/z3:4.6.0-llvm-8-ubuntu-$*

debian-%:
	# Build the image.
	docker-compose build --pull $@
	# Push to the public registry on dockerhub.
	docker push runtimeverificationinc/debian:$*
