defmodule BaseBlog.Repo.Migrations.CreateAuthorTable do
  use Ecto.Migration

  def change do
    create table(:author) do
      add :nickname, :string
      add :user_id, references(:user)

      timestamps()
    end
  end
end
