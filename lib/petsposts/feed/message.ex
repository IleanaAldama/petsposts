defmodule Petsposts.Feed.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :image_link, :text, :inserted_at]}

  schema "messages" do
    field :image_link, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:image_link, :text])
    |> validate_required([:text])
  end
end
