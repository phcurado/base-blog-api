defmodule BaseBlog.Repo.Migrations.CreateTagTable do
  use Ecto.Migration

  def change do
    create table(:tag) do
      add :name, :string, null: false

      timestamps()
    end
    create unique_index(:tag, [:name])
  end
end
