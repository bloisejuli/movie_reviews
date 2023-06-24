defmodule MovieReviewsWeb.MovieView do
  use MovieReviewsWeb, :view
  alias MovieReviews.Movies

  def get_posts_count(movie_id) do
    Movies.get_number_of_posts(movie_id)
  end
end
