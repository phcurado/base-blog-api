defmodule BaseBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :email, :string, null: false
      add :password_hash, :string
      add :name, :string
      add :birthday, :date

      timestamps()
    end
    create unique_index(:user, [:email])
  end
end
