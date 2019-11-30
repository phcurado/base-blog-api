defmodule BaseBlog.Posts do
	import Ecto.Query, warn: false
	
	alias BaseBlog.Repo
	alias BaseBlog.Posts.Post
	alias BaseBlog.Posts.Tag
	alias BaseBlog.Posts.LinkPostTag
	alias Helper.PaginationHelper

	# Post
	defp post_query() do
		from p in Post,
		join: a in assoc(p, :author),
		left_join: pt in LinkPostTag, on: p.id == pt.post_id,
		left_join: t in Tag, on: t.id == pt.tag_id,
    preload: [author: a, tags: t]
	end

	defp post_ordered_query(query) do
		query
		|> order_by([desc: :inserted_at])
	end

	def list_posts() do
		post_query()
		|> post_ordered_query()
		|> Repo.all()
	end

	def list_posts(page, size) do
		post_query()
		|> post_ordered_query()
		|> PaginationHelper.page(page, size)
		|> Repo.all()
	end

	def list_posts(page, size, params) do
		post_query()
		|> post_ordered_query()
		|> PaginationHelper.page(page, size)
		|> filter_by_title(params["title"])
		|> Repo.all()
	end

	defp filter_by_title(query, title) when not(is_nil(title)) do
		query |> where([p], ilike(p.title, ^("%" <> title <> "%")))
	end
	defp filter_by_title(query, _title), do: query

	def get_post!(id) do
		post_query()
		|> Repo.get!(id)
	end

	def get_post_by_slug(slug) do
    post_query()
    |> Repo.get_by(slug: slug)
  end

	def create_post(attrs \\ %{}) do
		%Post{}
    |> Post.changeset(attrs, parse_tags(attrs["tags"] || []))
		|> Repo.insert()
	end
	
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs, parse_tags(attrs["tags"] || []))
    |> Repo.update()
  end

	def delete_post(%Post{} = post) do
    Repo.delete(post)
	end
	
	# Tag
	
	def list_tags do
		Tag
		|> Repo.all()
	end
	
	def get_tag!(id) do
		Tag
		|> Repo.get!(id)
	end

	defp parse_tags(tags)  do
		tags
    |> Enum.map(&String.trim/1)
		|> Enum.reject(& &1 == "")
    |> insert_and_get_all_tags()
	end

	defp insert_and_get_all_tags(names) when is_list(names) do
		names
		|> Enum.map(&%{name: &1})
		|> Enum.each(fn tag -> create_tag(tag)	end)
    Repo.all(from t in Tag, where: t.name in ^names)
  end
	defp insert_and_get_all_tags([]), do: []
	
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
	end
	
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
	end
	
	def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
	end

end