defmodule BaseBlogWeb.PostController do
  use BaseBlogWeb, :controller

  alias BaseBlog.Posts
  alias BaseBlog.Posts.Post

  action_fallback BaseBlogWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    user = Guardian.Plug.current_resource(conn)
    post_params = Map.put(post_params, "author_id", user.author.id)
    with {:ok, %Post{} = post} <- Posts.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   author = Accounts.get_author!(id)

  #   with {:ok, %Author{}} <- Accounts.delete_author(author) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
