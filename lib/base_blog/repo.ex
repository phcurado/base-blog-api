defmodule BaseBlog.Repo do
  use Ecto.Repo,
    otp_app: :base_blog,
    adapter: Ecto.Adapters.Postgres
end
