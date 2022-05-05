# syntax=docker/dockerfile:1

FROM bitwalker/alpine-elixir-phoenix

ENV MIX_ENV dev

WORKDIR /
COPY local.entrypoint.sh .
RUN chmod +x /local.entrypoint.sh
ENTRYPOINT ["/local.entrypoint.sh"]

WORKDIR /app

ENV PORT 9000

CMD mix phx.server
