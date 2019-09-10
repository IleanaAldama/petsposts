defmodule Petsposts.Feed.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Petsposts.Feed.Message
  alias Petsposts.Accounts.User

  @derive {Jason.Encoder, only: [:id, :likes, :views, :message, :author, :inserted_at]}

  schema "posts" do
    field :likes, :integer, default: 0
    field :views, :integer, default: 0

    belongs_to :message, Petsposts.Feed.Message
    belongs_to :author, Petsposts.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    changeset = post
    |> cast(attrs, [:likes, :views, :author_id])
    |> cast_assoc(:message, with: &Message.changeset/2)
    |> cast_assoc(:author, with: &User.changeset/2)
    |> validate_required([:likes, :views, :message, :author])
  end
end
