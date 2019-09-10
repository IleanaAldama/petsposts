FROM node:latest as assets-builder
WORKDIR /app/assets
ADD ./assets /app/assets
RUN yarn install
RUN yarn run deploy

FROM elixir:latest as web
ENV MIX_ENV=dev
WORKDIR /app
ADD . /app
COPY --from=assets-builder /app/priv/static /app/priv/static
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix do deps.get, deps.compile, compile
EXPOSE 4000
CMD mix phx.server


