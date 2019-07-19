UBUNTU_PATTERNS := ubuntu-FLAVOR-rv \
                   ubuntu-FLAVOR-with-timezone-and-locale

UBUNTU_BIONIC_IMAGES := $(patsubst FLAVOR,bionic,$(UBUNTU_PATTERNS))
UBUNTU_XENIAL_IMAGES := $(patsubst FLAVOR,xenial,$(UBUNTU_PATTERNS))

.PHONY: $(UBUNTU_BIONIC_IMAGES) $(UBUNTU_XENIAL_IMAGES)

ubuntu-%-rv: ubuntu-%-with-timezone-and-locale
	docker-compose build --pull $@
	docker-compose push $@

ubuntu-%-with-timezone-and-locale:
	docker-compose build --pull $@
	docker-compose push $@
