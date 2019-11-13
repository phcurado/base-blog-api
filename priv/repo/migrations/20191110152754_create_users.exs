defmodule BaseBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string
      add :birthday, :date

      timestamps()
    end

    create index(:users, [:email], unique: true) 

  end
end
