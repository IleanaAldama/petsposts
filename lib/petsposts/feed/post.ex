defmodule Petsposts.Feed.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :author, :id
    field :message, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> validate_required([])
  end
end
