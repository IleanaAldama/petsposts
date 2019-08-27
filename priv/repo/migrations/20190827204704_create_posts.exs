defmodule Petsposts.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :author, references(:users, on_delete: :nothing)
      add :message, references(:messages, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:author])
    create index(:posts, [:message])
  end
end
