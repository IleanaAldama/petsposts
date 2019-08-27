defmodule PetspostsWeb.PostController do
  use PetspostsWeb, :controller

  alias Petsposts.Feed
  alias Petsposts.Feed.Post

  def index(conn, _params) do
    posts = Feed.list_posts()
    changeset = Feed.change_post(%Post{})
    render(conn, "index.html", posts: posts, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Feed.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Feed.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Feed.get_post!(id)
    render(conn, "show.html", post: post)
  end
end
