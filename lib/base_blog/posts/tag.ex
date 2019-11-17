defmodule BaseBlog.Posts.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BaseBlog.Posts.Post
  alias BaseBlog.Posts.LinkPostTag

  schema "tag" do
    field :name, :string
    many_to_many :posts, Post, join_through: LinkPostTag, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name) 
  end
end
