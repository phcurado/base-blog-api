defmodule BaseBlogWeb.Router do
  use BaseBlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BaseBlogWeb do
    pipe_through :api

    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    
    resources "/authors", AuthorController
  end
end
