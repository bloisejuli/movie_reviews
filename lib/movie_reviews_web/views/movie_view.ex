defmodule MovieReviewsWeb.MovieView do
  use MovieReviewsWeb, :view
  alias MovieReviews.Movies

  def get_posts_count(movie_id) do
    Movies.get_number_of_posts(movie_id)
  end

  def get_random_movie(list_movies) do
    list_ids = for movie <- list_movies, do: movie.id
    random_id = Enum.random(list_ids)

    Movies.get_movie!(random_id)
  end
end
