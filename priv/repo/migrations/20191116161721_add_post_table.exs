defmodule BaseBlog.Repo.Migrations.CreatePostTable do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :title, :string, null: false
      add :abstract, :string
      add :slug, :string, null: false
      add :html, :string
      add :status, :integer
      add :author_id, references(:author)

      timestamps()
    end
    create unique_index(:post, [:title])
    create unique_index(:post, [:slug])
  end
end
