ARG OS=ubuntu
ARG FLAVOR=bionic

FROM runtimeverificationinc/${OS}:${FLAVOR}

RUN apt-get update -q && \
    apt-get install -y wget

RUN wget -qO- https://get.haskellstack.org/ | sh

USER user:user

COPY --chown=user:user haskell.yaml.d/stack.yaml /home/user/haskell.yaml.d/stack.yaml
COPY --chown=user:user haskell.yaml.d/kore/package.yaml /home/user/haskell.yaml.d/kore/package.yaml

RUN    cd /home/user/haskell.yaml.d \
    && stack build --only-snapshot
