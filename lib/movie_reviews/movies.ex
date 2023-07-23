defmodule MovieReviews.Movies do
  import Ecto.Query, warn: false
  alias MovieReviews.Posts
  alias MovieReviews.Repo
  alias MovieReviews.Movies.Movie
  alias MovieReviews.Movies

  def list_movies do
    Repo.all(Movie)
  end

  def get_movie!(id), do: Repo.get!(Movie, id)

  def create_movie(attrs \\ %{}) do
    %Movie{}
    |> Movie.changeset(attrs)
    |> Repo.insert()
  end

  def update_movie(%Movie{} = movie, attrs) do
    movie
    |> Movie.changeset(attrs)
    |> Repo.update()
  end

  def delete_movie(%Movie{} = movie) do
    Repo.delete(movie)
  end

  def change_movie(%Movie{} = movie, attrs \\ %{}) do
    Movie.changeset(movie, attrs)
  end

  def add_post(movie_id, post_params, user_id, tag) do
    post_params
    |> Map.put("movie_id", movie_id)
    |> Map.put("user_id", user_id)
    |> Map.put("tag", tag)
    |> Posts.create_post()
  end

  @spec get_number_of_posts(any) :: non_neg_integer
  def get_number_of_posts(movie_id) do
    movie = Movies.get_movie!(movie_id) |> Repo.preload([:posts])
    Enum.count(movie.posts)
  end
end
