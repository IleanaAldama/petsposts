defmodule PetspostsWeb.PostApiView do
  use PetspostsWeb, :view

  def render("post.json", %{post: post}) do
    post
  end

  def render("post_error.json", %{reason: reason}) do
    %{error: reason}
  end

  def render("list_posts.json", %{posts: posts}) do
    %{posts: posts}
  end
end
