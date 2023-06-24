defmodule MovieReviews.Repo do
  use Ecto.Repo,
    otp_app: :movie_reviews,
    adapter: Ecto.Adapters.Postgres
end
