defmodule BaseBlogWeb.AuthorView do
  use BaseBlogWeb, :view
  alias BaseBlogWeb.AuthorView

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{id: author.id,
      name: author.name,
      age: author.age}
  end

  def author_serial(%{author: author}) do
    %{id: author.id,
      name: author.name,
      age: author.age
    }
  end
end
