defmodule BaseBlog.Accounts do
  import Ecto.Query, warn: false
  alias BaseBlog.Repo
  alias BaseBlog.Accounts.User
  alias BaseBlog.Posts.Author
  alias BaseBlog.Guardian
  import Bcrypt, only: [check_pass: 2]

  def list_users do
    user_query()
    |> Repo.all()
  end

  def user_query() do
    from u in User,
    join: a in assoc(u, :author),
    preload: [author: a]
  end

  def get_user!(id) do
    user_query()
    |> Repo.get!(id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def token_sign_in(email, password) do
    case user_email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end

  defp user_email_password_auth(email, password) do
    email
    |> get_user_by_email()
    |> Map.put(:password, password)
    |> verify_user()
  end

  defp get_user_by_email(email) do
    user_query()
    |> Repo.get_by(email: email)
  end

  defp verify_user(%{password: password} = user) do
    user
    |> check_pass(password)
  end
end
