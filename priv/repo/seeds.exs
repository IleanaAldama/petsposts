# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Petsposts.Repo.insert!(%Petsposts.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Petsposts.Repo
alias Petsposts.Accounts.User
alias Petsposts.Feed.{Message, Post}

defmodule Petsposts.Seeds do
  def insert_user(raw_user) do
    %User {
      avatar: raw_user.avatar,
      email: raw_user.email,
      last_name: raw_user.lastName,
      name: raw_user.name,
      username: raw_user.username
    } |> Repo.insert!()
  end

  def insert_message(raw_message) do
    %Message {
      image_link: raw_message.body.image,
      text: raw_message.body.text,
    } |> Repo.insert!()
  end
end

"./priv/repo/posts_data.json"
|> File.read!()
|> Jason.decode!(keys: :atoms)
|> Map.get(:posts)
|> Enum.each(fn raw_post ->
    author = Petsposts.Seeds.insert_user(raw_post.author)
    message = Petsposts.Seeds.insert_message(raw_post.message)
    %Post {
      author_id: author.id,
      message_id: message.id,
      likes: raw_post.message.likes,
      views: raw_post.message.views,
    } |> Repo.insert!()
end)
