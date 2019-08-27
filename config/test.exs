use Mix.Config

# Configure your database
config :petsposts, Petsposts.Repo,
  username: "postgres",
  password: "postgres",
  database: "petsposts_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :petsposts, PetspostsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
