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

# Locale.
RUN apt-get update -qq \
    && apt-get install --yes locales \
    && echo "${LOCALE} UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=${LOCALE} LC_ALL=${LOCALE} LANGUAGE=en_US:en

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
