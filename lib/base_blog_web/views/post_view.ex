defmodule BaseBlogWeb.PostView do
  use BaseBlogWeb, :view
  
  import Helper.MapHelper

  alias BaseBlogWeb.PostView
  alias BaseBlogWeb.AuthorView
  alias BaseBlogWeb.TagView
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
    |> add_relation(:tags, render_tags(post.tags))
  end

  defp mount_base_struct(%Post{} = post) do
    %{
      id: post.id,
      title: post.title,
      abstract: post.abstract,
      slug: post.slug,
      html: post.html,
      status: post.status,
      inserted_at: post.inserted_at
    }
  end

  defp render_author(%Author{} = author) do
    render_one(author, AuthorView, "author.json")
  end
  defp render_author(_), do: nil

  defp render_tags(tags) when is_list(tags) do
    render_many(tags, TagView, "tag.json")
  end
  defp render_tags(_), do: nil
  
end
