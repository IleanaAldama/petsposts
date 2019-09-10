defmodule Petsposts.Feed do

  alias Petsposts.Feed.Pagination
  @moduledoc """
  The Feed context.
  """

  import Ecto.Query, warn: false
  alias Petsposts.Repo
  alias Petsposts.Feed.{Post, Message}
  alias Petsposts.Accounts
  alias Ecto.Changeset

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(pagination) do
    Post
    |> Pagination.page(pagination)
    |> Repo.all()
    |> Repo.preload([:author, :message])
  end

  def list_posts() do
    Post
    |> Repo.all()
    |> Repo.preload([:author, :message])
  end


  def total_posts do
    Post
    |> select([p], count(p.id))
    |> Repo.one!()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id) |> Repo.preload([:author, :message])

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs, user) do
    attrs = attrs
    |> Map.put("message", %{text: attrs["text"], image_link: ""})
    |> Map.put("author", Map.from_struct user)
    %Post{author: user}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def create_post(attrs) do
    case Accounts.get(attrs["author"]) do
      nil ->
        {:error, "invalid author"}
      user ->
        %Post{author: user}
        |> Post.changeset(attrs)
        |> Repo.insert()
    end
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
