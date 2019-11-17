defmodule BaseBlog.Posts.Post do
	use Ecto.Schema
	import Ecto.Changeset
	alias BaseBlog.Posts.Author

	schema "post" do
		field :title, :string
		field :slug, :string
		field :html, :string
		field :status, :integer
		belongs_to :author, Author

		timestamps()
	end

	@doc false
	def changeset(post, attrs) do
		attrs = put_slug(attrs)
		post
		|> cast(attrs, [:title, :slug, :html, :status, :author_id])
		|> validate_required([:title, :slug, :status, :author_id])
		|> validate_length(:title, min: 8, max: 50)
		|> foreign_key_constraint(:author_id)
	end
	
	defp put_slug(%{"title" => title} = attrs) when is_nil(title) == false do
		attrs
		|> Map.put("slug", String.replace(title, " ", "-"))
	end
	defp put_slug(attrs), do: attrs
end