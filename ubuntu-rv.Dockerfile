ARG FLAVOR=bionic
FROM ubuntu:${FLAVOR}

ARG TIMEZONE="America/Chicago"
ARG LOCALE="en_US.UTF-8"
ARG USER_ID=1001
ARG GROUP_ID=1001

# Timezone.
RUN ln --symbolic --no-dereference --force /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone

# Locale.
RUN apt-get update -qq \
    && apt-get install --yes locales \
    && locale-gen --no-purge "${LOCALE}"

ENV LANG="${LOCALE}" \
    LC_ALL="${LOCALE}" \
    LANGUAGE="en_US:en"

RUN update-locale

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
