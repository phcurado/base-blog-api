# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :base_blog,
  ecto_repos: [BaseBlog.Repo]

# Configures the endpoint
config :base_blog, BaseBlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JKhN99Xd0cOyhvNiqnqEhA+49y0KWOq4bE2r+lqQnjEy6YoxoGVuVEJ/tZXQfJsU",
  render_errors: [view: BaseBlogWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BaseBlog.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
