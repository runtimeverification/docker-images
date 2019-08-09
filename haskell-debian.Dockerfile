ARG OS=ubuntu
ARG FLAVOR=bionic

FROM runtimeverificationinc/${OS}:${FLAVOR}

RUN apt-get update -q && \
    apt-get install -y wget libtinfo-dev

USER user:user

# Puts the `stack` executable in /usr/local/bin.
RUN wget -qO- https://get.haskellstack.org/ | sh

COPY --chown=user:user \
     haskell.yaml.d/ \
     /home/user/haskell.yaml.d/

RUN    cd /home/user/haskell.yaml.d \
    && stack build --only-snapshot
