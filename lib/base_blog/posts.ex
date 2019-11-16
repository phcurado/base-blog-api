defmodule BaseBlog.Posts do
	import Ecto.Query, warn: false
	alias BaseBlog.Repo
	alias BaseBlog.Posts.Post

	def post_query() do
		from p in Post
	end

	def list_posts do
		post_query()
		|> Repo.all()
	end

	def get_post!(id) do
		post_query()
		|> Repo.get!(id)
	end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
	end
	
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

	def delete_post(%Post{} = post) do
    Repo.delete(post)
  end
end