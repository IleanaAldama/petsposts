defmodule Petsposts.Feed.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    belongs_to :message, Petsposts.Feed.Message
    belongs_to :author, Petsposts.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> validate_required([])
  end
end
