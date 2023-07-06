defmodule MovieReviews.MoviesRandom do
  alias MovieReviews.Movies

  def get_random_movie() do
    list = Movies.list_movies()
    Enum.take_random(list, 1)
  end
end
