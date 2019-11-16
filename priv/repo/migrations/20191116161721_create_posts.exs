defmodule BaseBlog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false 
      add :slug, :string, null: false
      add :html, :string
      add :status, :integer
      add :author_id, references(:authors)  
    end

  end
end
