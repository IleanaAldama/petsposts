defmodule Petsposts.Repo do
  use Ecto.Repo,
    otp_app: :petsposts,
    adapter: Ecto.Adapters.Postgres
end
