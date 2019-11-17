defmodule BaseBlogWeb.UserView do
  use BaseBlogWeb, :view

  import Helper.MapHelper

  alias BaseBlogWeb.UserView
  alias BaseBlogWeb.AuthorView
  alias BaseBlog.Accounts.User
  alias BaseBlog.Posts.Author

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    user
    |> mount_base_struct()
    |> add_relation(:author, render_author(user.author))
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  defp mount_base_struct(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      birthday: user.birthday
    }
  end

  defp render_author(%Author{} = author) do
    render_one(author, AuthorView, "author.json")
  end
  defp render_author(_), do: nil
  
end
