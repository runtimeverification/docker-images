ARG OS=ubuntu
ARG FLAVOR=bionic

FROM ${OS}:${FLAVOR}

ARG OS=ubuntu
ARG FLAVOR=bionic

RUN apt-get update -q && \
    apt-get install -y wget
    
RUN wget https://raw.githubusercontent.com/commercialhaskell/stack/v2.1.1/etc/scripts/get-stack.sh

RUN    mkdir /haskell-stack \
    && sh get-stack.sh -d /haskell-stack
