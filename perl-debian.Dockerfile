ARG OS=ubuntu
ARG FLAVOR=bionic

FROM runtimeverificationinc/${OS}:${FLAVOR}

RUN    apt-get update -q \
    && apt-get install --yes cpanminus make

USER user:user

RUN cpanm --local-lib=~/perl5 local::lib               \
  && eval $(perl -I "~/perl5/lib/perl5/" -Mlocal::lib) \
  && cpanm -L ~/perl5                                  \
        App::FatPacker                                 \
        Getopt::Declare                                \
        String::Escape                                 \
        String::ShellQuote                             \
        UUID::Tiny
