defmodule BaseBlog.Accounts.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias BaseBlog.Accounts.User

  schema "authors" do
    field :age, :integer
    field :name, :string
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
