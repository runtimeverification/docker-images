ARG FLAVOR=bionic
FROM localhost:5201/ubuntu-with-timezone-and-locale:${FLAVOR}

RUN apt-get update -qq \
    && apt-get install --yes sudo

ARG USER_ID=1001
ARG GROUP_ID=1001

RUN addgroup --gid ${GROUP_ID} user \
  && adduser --uid ${USER_ID} \
             --gid ${GROUP_ID} \
             --shell /bin/sh \
             --disabled-password \
             --gecos "" \
             user \
  && usermod -aG sudo user \
  && echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user
