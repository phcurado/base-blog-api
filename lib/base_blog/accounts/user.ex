defmodule BaseBlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Bcrypt, only: [hash_pwd_salt: 1]
  alias BaseBlog.Accounts.Author


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :name, :string
    field :birthday, :date
    has_one :author, Author
    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :birthday, :password, :password_confirmation])
    |> validate_required([:email, :name, :birthday, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/) # Check that email is valid
    |> validate_length(:password, min: 8) # Check that password length is >= 8 
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> unique_constraint(:email) 
    |> put_password_hash
    |> cast_assoc(:author, with: &BaseBlog.Accounts.Author.changeset/2)
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end
  defp put_password_hash(changeset), do: changeset

end
