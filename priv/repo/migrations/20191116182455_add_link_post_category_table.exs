defmodule BaseBlog.Repo.Migrations.CreateLinkPostTagTable do
  use Ecto.Migration

  def change do
    create table(:link_post_tag, primary_key: false) do
      add(:post_id, references(:post, on_delete: :delete_all), primary_key: true)
      add(:tag_id, references(:tag, on_delete: :delete_all), primary_key: true)

      timestamps()
    end
  end
end
