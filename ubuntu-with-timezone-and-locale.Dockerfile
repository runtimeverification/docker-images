ARG FLAVOR=bionic
FROM ubuntu:${FLAVOR}

ARG TIMEZONE="America/Chicago"
ARG LOCALE="en_US.UTF-8"

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
