# Common debian-based base image for `kframework` projects
# (https://github.com/kframework).
#
# The purpose of this image is to provide the common
# `APT` package dependencies.
#
#
# Inherits the following from `runtimeverificationinc/OS:FLAVOR`:
#
# * default `user`
# * LLVM apt repositories for versions 7 and 8
#
#
# Package requirements not included here.
#
# k:           z3 libz3-dev 
#
# c-semantics: clang++-6.0 clang-6.0 openjdk-8-jdk
#              libstdc++6 llvm-6.0


ARG OS=ubuntu
ARG FLAVOR=bionic

FROM runtimeverificationinc/${OS}:${FLAVOR}

RUN    apt-get update  -q                                                      \
    && apt-get install --yes                                                   \
         autoconf bison cmake curl flex gcc libboost-test-dev                  \
         libcrypto++-dev libffi-dev libjemalloc-dev libmpfr-dev libprocps-dev  \
         libprotobuf-dev libsecp256k1-dev libssl-dev libtool libyaml-dev       \
         make maven opam openjdk-11-jdk pandoc pkg-config                      \
         protobuf-compiler python3 python-pygments python-recommonmark         \
         python-sphinx time zlib1g-dev                                         \
         clang-8 llvm-8-tools lld-8                                            \
         git debhelper libgmp-dev                                              \
         build-essential coreutils m4 python-jinja2 libxml2 unifdef cpanminus  \
         diffutils libyaml-cpp-dev
