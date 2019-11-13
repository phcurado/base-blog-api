defmodule BaseBlog.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :age, :integer
      add :user_id, references(:users)

      timestamps()
    end

  end
end
