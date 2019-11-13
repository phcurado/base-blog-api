defmodule BaseBlogWeb.Router do
  use BaseBlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BaseBlogWeb do
    pipe_through :api
    resources "/users", UserController
    resources "/authors", AuthorController
  end
end
