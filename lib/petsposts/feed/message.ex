defmodule Petsposts.Feed.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :image_link, :string
    field :text, :string
    field :likes, :integer
    field :views, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:image_link, :text, :likes, :views])
    |> validate_required([:image_link, :text, :likes, :views])
  end
end
