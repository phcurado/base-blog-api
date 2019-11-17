defmodule BaseBlogWeb.TagView do
  use BaseBlogWeb, :view
  alias BaseBlogWeb.TagView
  alias BaseBlog.Posts.Tag

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    tag
    |> mount_base_struct()
  end

  defp mount_base_struct(%Tag{} = tag) do
    %{
      id: tag.id,
      name: tag.name
    }
  end

end
