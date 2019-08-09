ARG OS=ubuntu
ARG FLAVOR=bionic

FROM runtimeverificationinc/${OS}:${FLAVOR}

RUN apt-get update -q && \
    apt-get install -y \
      opam \
      pkg-config \
      m4 \
      libffi-dev \
      libgmp-dev \
      libmpfr-dev

USER user:user

COPY --chown=user:user \
     opam-stuff \
     /home/user/opam-stuff

RUN sh /home/user/opam-stuff/bin/k-configure-opam-dev
