defmodule BaseBlog.Posts do
	import Ecto.Query, warn: false
	alias BaseBlog.Repo
	alias BaseBlog.Posts.Post
	alias BaseBlog.Posts.Category

	# Post
	
	def post_query() do
    from p in Post,
    join: a in assoc(p, :author),
    preload: [author: a]
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
	
	# Category
	
	def list_categories do
		Category
		|> Repo.all()
	end
	
	def get_category!(id) do
		Category
		|> Repo.get!(id)
	end


  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
	end
	
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
	end
	
	def delete_category(%Category{} = category) do
    Repo.delete(category)
	end

end