defmodule BaseBlog.Repo.Migrations.AlterPostTableHtmlColumnSize do
  use Ecto.Migration

  def change do
    alter table(:post) do
      modify :html, :string, size: 10000
    end
  end
end
