# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :movie_reviews,
  ecto_repos: [MovieReviews.Repo]

# Configures the endpoint
config :movie_reviews, MovieReviewsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ahF9YicJNPUmr9337Ztkxrfb7KCG61wP/AVjOJanP9zI4kB+HdM940rTKEsYItAV",
  render_errors: [view: MovieReviewsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MovieReviews.PubSub,
  live_view: [signing_salt: "VZMUx1+8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :movie_reviews, :pow,
  web_module: MovieReviewsWeb,
  user: MovieReviews.Users.User,
  repo: MovieReviews.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :movie_reviews, :base_url, "https://api.themoviedb.org/3"
config :movie_reviews, :api_key, "e1ad0f689f3ac23b2469621fb3f23b02"
