#########
# Builds rust from source with a given version of LLVM.
# Does not compile cargo and rustup. We download them instead.
#
# Client images are expected to copy
#
# - /root/.cargo
# - /root/.rustup
# - /rustc-${RUST_VERSION}-src
#
# And run
#
# RUN    cd rustc-${RUST_VERSION}-src \
#    && /home/user/.cargo/bin/rustup \
#         toolchain \
#         link \
#         rust-${RUST_VERSION}-llvm-${LLVM_VERSION} \
#         build/x86_64-unknown-linux-gnu/stage2
#
# which exposes the rust toolchain.
#########

ARG FLAVOR=bionic
FROM ubuntu:${FLAVOR}
ARG FLAVOR=bionic

ARG LLVM_VERSION=8
ARG RUST_VERSION=1.34.0

# Add the LLVM apt repositories, if needed.
RUN if [ "${FLAVOR}" != "bionic" ]; then \
      echo "deb http://apt.llvm.org/${FLAVOR}/ llvm-toolchain-${FLAVOR}-${LLVM_VERSION} main" \
        > /etc/apt/sources.list.d/llvm.list && \
      echo "deb-src http://apt.llvm.org/${FLAVOR}/ llvm-toolchain-${FLAVOR}-${LLVM_VERSION} main" \
        >> /etc/apt/sources.list.d/llvm.list && \
      apt-get update -q && \
      apt-get install -y wget && \
      wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - ; \
    fi

# Install packages.
RUN apt-get update -q && \
    apt-get install -y --no-install-recommends \
      make \
      cmake \
      python2.7 \
      curl \
      perl \
      clang-${LLVM_VERSION} \
      llvm-${LLVM_VERSION}-tools \
      ca-certificates 

# Download the rust source.
RUN curl -L https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.gz \
      -o rustc-${RUST_VERSION}-src.tar.gz

# Check the checksum.
COPY rust_checksum ./rust_checksum
RUN shasum -a 512 -c rust_checksum

# Install rustup.
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN tar xf rustc-${RUST_VERSION}-src.tar.gz

RUN    cd rustc-${RUST_VERSION}-src \
    && ./configure \
         --llvm-root=$(llvm-config-${LLVM_VERSION} --prefix 2>/dev/null) \
         --enable-llvm-link-shared

# This is required for the next step.
RUN    ln -sf $(which clang-${LLVM_VERSION}) /usr/bin/cc \
    && ln -sf $(which clang++-${LLVM_VERSION}) /usr/bin/c++

# Build rust.
RUN    cd rustc-${RUST_VERSION}-src \
    && ./x.py build
