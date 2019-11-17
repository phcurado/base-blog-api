defmodule BaseBlog.Posts.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias BaseBlog.Posts.Post

  schema "category" do
    field :name, :string
    many_to_many :posts, Post, join_through: "link_post_category", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
