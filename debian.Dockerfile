ARG OS=ubuntu
ARG FLAVOR=bionic

FROM ${OS}:${FLAVOR}

ARG OS=ubuntu
ARG FLAVOR=bionic

ARG TIMEZONE="America/Chicago"
ARG LOCALE="en_US.UTF-8"
ARG USER_ID=1001
ARG GROUP_ID=1001

# Timezone.
RUN ln --symbolic --no-dereference --force /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone

# Default user.
RUN apt-get update -qq \
    && apt-get install --yes sudo

RUN addgroup --gid ${GROUP_ID} user \
  && adduser --uid ${USER_ID} \
             --gid ${GROUP_ID} \
             --shell /bin/sh \
             --disabled-password \
             --gecos "" \
             user \
  && usermod -aG sudo user \
  && echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user

# Add LLVM repositories, if needed (versions 7 and 8).
RUN apt-get update -q \
    && apt-get install -y wget gnupg2

RUN if [ -z "$(apt-cache search --names-only llvm-8-tools)" ]; then \
      echo "deb http://apt.llvm.org/${FLAVOR}/ llvm-toolchain-${FLAVOR}-8 main" \
        > /etc/apt/sources.list.d/llvm.list && \
      echo "deb-src http://apt.llvm.org/${FLAVOR}/ llvm-toolchain-${FLAVOR}-8 main" \
        >> /etc/apt/sources.list.d/llvm.list && \
      wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - ; \
    fi
RUN if [ -z "$(apt-cache search --names-only llvm-7-tools)" ]; then \
      echo "deb http://apt.llvm.org/${FLAVOR}/ llvm-toolchain-${FLAVOR}-7 main" \
        >> /etc/apt/sources.list.d/llvm.list && \
      echo "deb-src http://apt.llvm.org/${FLAVOR}/ llvm-toolchain-${FLAVOR}-7 main" \
        >> /etc/apt/sources.list.d/llvm.list && \
      wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - ; \
    fi
