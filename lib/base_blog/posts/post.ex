defmodule BaseBlog.Posts.Post do
	use Ecto.Schema
	import Ecto.Changeset
	alias BaseBlog.Posts.Author
	alias BaseBlog.Posts.Tag
	alias BaseBlog.Posts.LinkPostTag

	schema "post" do
		field :title, :string
		field :abstract, :string
		field :slug, :string
		field :html, :string
		field :status, :integer
		belongs_to :author, Author
		many_to_many :tags, Tag, join_through: LinkPostTag, on_replace: :delete

		timestamps()
	end

	@doc false
	def changeset(post, attrs) do
		attrs = put_slug(attrs)
		post
		|> cast(attrs, [:title, :abstract, :slug, :html, :status, :author_id])
		|> validate_required([:title, :abstract, :slug, :status, :author_id])
		|> validate_length(:title, min: 5, max: 50)
		|> validate_length(:abstract, min: 5, max: 150)
		|> unique_constraint(:title)
		|> unique_constraint(:slug)
		|> foreign_key_constraint(:author_id)
	end
	def changeset(post, attrs, tags) do
		changeset(post, attrs)
		|> put_assoc(:tags, tags)
	end
	
	defp put_slug(%{"title" => title} = attrs) when is_nil(title) == false do
		add_edit_slug(attrs, Map.has_key?(attrs, "slug"))
	end
	defp add_edit_slug(attrs, _has_slug =  true) do
		update_slug(attrs, attrs["slug"])
	end
	defp add_edit_slug(%{"title" => title} = attrs, _has_slug) do
		update_slug(attrs, title)
	end
	defp update_slug(attrs, str) do
		attrs
		|> Map.put("slug", str |> clean_slug_str())
	end
	defp clean_slug_str(slug) do
		slug
		|> String.replace(~r/[^a-zA-Z0-9 ]/, "")
		|> String.replace(" ", "-")
	end
end