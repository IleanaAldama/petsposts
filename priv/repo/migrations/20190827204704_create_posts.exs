defmodule Petsposts.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :author_id, references(:users, on_delete: :nothing)
      add :message_id, references(:messages, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:author_id])
    create index(:posts, [:message_id])
  end
end
