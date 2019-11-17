defmodule BaseBlogWeb.AuthorView do
  use BaseBlogWeb, :view
  alias BaseBlogWeb.AuthorView
  alias BaseBlog.Posts.Author

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    author
    |> mount_base_struct()
  end

  defp mount_base_struct(%Author{} = author) do
    %{
      id: author.id,
      nickname: author.nickname
    }
  end

end
