defmodule Petsposts.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :image_link, :string
      add :text, :text

      timestamps()
    end

  end
end
