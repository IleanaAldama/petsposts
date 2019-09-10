defmodule PetspostsWeb.PostApiController do
  use PetspostsWeb, :controller
  alias Petsposts.Feed

  def create(conn, params) do
    case Feed.create_post(params) do
      {:ok, post} ->
        render(conn, "post.json", post: post)

      {:error, reason} ->
        conn
        |> put_status(400)
        |> render("post_error.json", reason: reason)
    end
  end

  def index(conn, _params) do
    render(conn, "list_posts.json", posts: Feed.list_posts())
  end

  def show(conn, params) do
    params
    |> Map.get("id")
    |> Feed.get_post!()
    |> (&(render conn, "post.json", post: &1)).()
  end
end
