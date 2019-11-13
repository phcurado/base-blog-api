defmodule BaseBlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BaseBlog.Accounts.Author

  schema "users" do
    field :email, :string
    field :name, :string
    field :birthday, :date
    has_one :author, Author

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    # Ecto.build_assoc(user, )
    IO.inspect user
    IO.inspect attrs
    user
    |> cast(attrs, [:email, :name, :birthday])
    |> cast_assoc(:author, with: &BaseBlog.Accounts.Author.changeset/2)
    |> validate_required([:email, :name, :birthday])
  end
end
