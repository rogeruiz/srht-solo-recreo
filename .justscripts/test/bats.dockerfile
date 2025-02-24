FROM bats/bats

RUN \
  apk \
  --no-cache \
  --update \
  add \
  coreutils \
  nodejs

ARG JUST_VERSION=1.39.0
ARG JWT_VERSION=6.2.0
ARG JQ_VERSION=1.7.1

# Install the necessary tooling that needs to exist for the Just recipes

RUN \
  wget -O - https://github.com/casey/just/releases/download/${JUST_VERSION}/just-${JUST_VERSION}-x86_64-unknown-linux-musl.tar.gz \
  | tar --directory /usr/local/bin --extract --gzip --file - just

WORKDIR /opt/test
