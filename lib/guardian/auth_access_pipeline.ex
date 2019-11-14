defmodule BaseBlog.AuthAccessPipeline do
    use Guardian.Plug.Pipeline, otp_app: :base_blog,
    module: BaseBlog.Guardian,
    error_handler: BaseBlog.AuthErrorHandler
  
    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource, allow_blank: true
end