# =============
# Documentation
# =============
#
# -------
# build-%
# -------
#
# Builds (`docker build`)
# the image that comes after the dash.
# That part, i.e., `$*`, is the name of the
# image listed in docker-compose.yml
#
# ------
# push-%
# ------
#
# Pushes the image that comes after the dash
# to dockerhub.
#
# The image name and tag are extracted from
# `$*`, so that, for example,
# `make push-haskell-ubuntu-bionic`
# pushes `runtimeverificationinc/haskell:ubuntu-bionic`.
#
#
# Example: `make haskell-ubuntu-bionic`
# will use the most generic rule, i.e., `%`,
# which then invokes, in sequence, the two rules described above.


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
