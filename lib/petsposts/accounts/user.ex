defmodule Petsposts.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :avatar, :email, :last_name, :name, :username, :inserted_at]}

  schema "users" do
    field :avatar, :string
    field :email, :string
    field :last_name, :string
    field :name, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :avatar, :name, :last_name])
    |> validate_required([:email, :username, :avatar, :name, :last_name])
  end
end
