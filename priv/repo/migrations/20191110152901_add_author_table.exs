defmodule BaseBlog.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:author) do
      add :nickname, :string
      add :user_id, references(:user)

      timestamps()
    end
  end
end
