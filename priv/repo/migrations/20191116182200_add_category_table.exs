defmodule BaseBlog.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:category) do
      add :name, :string, null: false

      timestamps()
    end
    create unique_index(:category, [:name])
  end
end
