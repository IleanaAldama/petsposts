defmodule Petsposts.Accounts do
  import Ecto.Query, warn: false
  alias Petsposts.Repo
  alias Petsposts.Accounts.User


  def current_user do
    Repo.get(User, 1)
  end

  def get(%{"id" => id}) when is_number(id), do: Repo.get!(User, id)
  def get(_), do: nil
end
