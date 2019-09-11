# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :petsposts,
  ecto_repos: [Petsposts.Repo]

# Configures the endpoint
# config :petsposts, PetspostsWeb.Endpoint,
#   url: [host: "localhost"],
#   secret_key_base: "nVno91xQnZyolRHyLz/+oT5wzTZ06by95Qe3rw0SpliMOw8gThZiTi6ySByhbYVA",
#   render_errors: [view: PetspostsWeb.ErrorView, accepts: ~w(html json)],
#   pubsub: [name: Petsposts.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure your database
config :petsposts, Petsposts.Repo,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASS"),
  database: System.get_env("DB_NAME"),
  hostname: System.get_env("DB_HOST"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :petsposts, :api_auth_token,
  System.get_env("API_AUTH_TOKEN")



# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
