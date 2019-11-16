defmodule BaseBlogWeb.Router do
  use BaseBlogWeb, :router
  alias BaseBlog.AuthAccessPipeline

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BaseBlogWeb do
    pipe_through :api

    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    
    resources "/posts", PostController
  end

  scope "/api", BaseBlogWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/me", UserController, :show
    put "/users/:id", UserController, :update
  end
  
  pipeline :jwt_authenticated do
    plug AuthAccessPipeline
  end

end
