# syntax=docker/dockerfile:1

ARG DEBIAN_VERSION=bullseye-20210902-slim
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"
FROM ${RUNNER_IMAGE}

ENV MIX_ENV prod

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add entrypoint to initialize Nullstone
WORKDIR /
COPY entrypoint.sh .
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /app
RUN chown nobody /app
USER nobody

ENV PORT 9000

CMD ["/app/bin/server"]
