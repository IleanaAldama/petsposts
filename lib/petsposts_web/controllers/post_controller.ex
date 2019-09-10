defmodule PetspostsWeb.PostController do
  use PetspostsWeb, :controller

  alias Petsposts.Feed
  alias Petsposts.Feed.{Post, Pagination}

  def index(conn, params) do
    total_posts = Feed.total_posts
    params = Map.put(params, "total_items", total_posts)
    {:ok, pagination} = Pagination.from_attrs(params)
    assigns = [
      posts: Feed.list_posts(pagination),
      changeset: Feed.change_post(%Post{}),
      page: pagination.page,
      next_page: pagination.page + 1,
      prev_page: pagination.page - 1,
      total_pages: pagination.total_pages
    ]
    render(conn, "index.html", assigns)
  end

  def new(conn, _params) do
    changeset = Feed.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Feed.create_post(post_params, conn.assigns[:current_user]) do
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
