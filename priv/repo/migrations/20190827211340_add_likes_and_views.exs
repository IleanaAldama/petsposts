defmodule Petsposts.Repo.Migrations.AddLikesAndViews do
  use Ecto.Migration

  def change do
    alter table :posts do
      add :likes, :integer
      add :views, :integer
    end

  end
end
