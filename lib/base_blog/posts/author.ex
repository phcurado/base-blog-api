defmodule BaseBlog.Posts.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias BaseBlog.Accounts.User
  alias BaseBlog.Posts.Post

  schema "author" do
    field :nickname, :string
    belongs_to :user, User
    has_many :posts, Post
    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:nickname])
    |> validate_required([:nickname])
  end
end
