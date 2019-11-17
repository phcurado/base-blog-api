defmodule BaseBlogWeb.PostView do
  use BaseBlogWeb, :view
  
  import Helper.MapRelation

  alias BaseBlogWeb.PostView
  alias BaseBlogWeb.AuthorView
  alias BaseBlog.Posts.Author
  alias BaseBlog.Posts.Post

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    mount_base_struct(post)
    |> add_relation(:author, render_author(post.author))
  end

  defp mount_base_struct(%Post{} = post) do
    %{
      id: post.id,
      title: post.title,
      slug: post.slug,
      html: post.html,
      status: post.status
      #categories: render_many(post.categories, CategoryView, "category.json")} #testar
    }
  end

  defp render_author(%Author{} = author) do
    render_one(author, AuthorView, "author.json")
  end
  defp render_author(_), do: nil
  
end
