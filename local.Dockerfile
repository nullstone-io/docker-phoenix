# syntax=docker/dockerfile:1

FROM elixir:alpine

# Install NPM
RUN \
    apk update && \
    apk --no-cache --update add \
      make \
      g++ \
      wget \
      curl \
      inotify-tools \
      nodejs \
      npm && \
    npm install npm -g --no-progress && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

# Add local node module binaries to PATH
ENV PATH=./node_modules/.bin:$PATH

# Install latest versions of Hex/Rebar
RUN mix do local.hex --force, local.rebar --force

ENV MIX_ENV dev

WORKDIR /
COPY local.entrypoint.sh .
RUN chmod +x /local.entrypoint.sh
ENTRYPOINT ["/local.entrypoint.sh"]

WORKDIR /app

ENV PORT 9000

CMD ["mix", "phx.server"]
