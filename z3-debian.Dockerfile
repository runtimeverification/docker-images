#########
# Builds Z3 from source with a given LLVM version.

ARG OS=ubuntu
ARG FLAVOR=bionic

FROM runtimeverificationinc/${OS}:${FLAVOR}

ARG OS=ubuntu
ARG FLAVOR=bionic

ARG LLVM_VERSION=8
ARG Z3_VERSION=4.6.0

# Install required packages.
RUN apt-get update -q &&     \
    apt-get install -y       \
      git                    \
      python                 \
      make                   \
      clang-${LLVM_VERSION}

# Clone z3.
RUN git clone 'https://github.com/z3prover/z3' --branch=z3-${Z3_VERSION}

# Configure z3.
RUN    cd z3                       \
    && CXX=clang++-${LLVM_VERSION} \
       CC=clang-${LLVM_VERSION}    \
       python scripts/mk_make.py

# Build z3.
RUN    cd z3/build     \
    && make -j$(nproc)
