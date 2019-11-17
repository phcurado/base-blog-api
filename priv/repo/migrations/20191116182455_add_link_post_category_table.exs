defmodule BaseBlog.Repo.Migrations.CreateLinkPostCategory do
  use Ecto.Migration

  def change do
    create table(:link_post_category, primary_key: false) do
      add(:post_id, references(:post, on_delete: :delete_all), primary_key: true)
      add(:category_id, references(:category, on_delete: :delete_all), primary_key: true)

      timestamps()
    end
  end
end
