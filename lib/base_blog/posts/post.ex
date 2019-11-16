defmodule BaseBlog.Posts.Post do
	use Ecto.Schema
	import Ecto.Changeset
	alias BaseBlog.Posts.Author

	schema "posts" do
		field :title, :string
		field :slug, :string
		field :html, :string
		field :status, :integer
		belongs_to :author, Author
    
		timestamps()
	end

	@doc false
	def changeset(post, attrs) do
		post
		|> cast(attrs, [:title, :slug, :html, :status])
		|> validate_required([:title, :slug, :status, :author])
		|> validate_length(:title, min: 8, max: 50) 
	end
end