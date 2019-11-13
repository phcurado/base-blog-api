defmodule BaseBlogWeb.UserView do
  use BaseBlogWeb, :view
  alias BaseBlogWeb.UserView
  alias BaseBlogWeb.AuthorView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      password_hash: user.password_hash,
      name: user.name,
      birthday: user.birthday,
      author: AuthorView.author_serial(user) 
    }
  end
  
  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
