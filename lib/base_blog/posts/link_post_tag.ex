defmodule BaseBlog.Posts.LinkPostTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BaseBlog.Posts.Tag
	alias BaseBlog.Posts.Post
	
	@primary_key false
	schema "link_post_tag" do
		belongs_to :post, Post, primary_key: true
		belongs_to :tag, Tag, primary_key: true
		timestamps()
	end
end