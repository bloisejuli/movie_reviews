defmodule MovieReviewsWeb.MovieController do
  # alias MovieReviews.Users
  # alias Hex.API.User
  use MovieReviewsWeb, :controller

  import Pow.Plug
  alias MovieReviews.Repo
  alias MovieReviews.Movies
  alias MovieReviews.Movies.Movie
  alias MovieReviews.Posts.Post, as: Post
  import MovieReviewsWeb.ValidationHelpers

  # alias MovieReviews.MovieFinder

  def index(conn, _params) do
    movies = Movies.list_movies()
    render(conn, "index.html", movies: movies)
  end

  def new(conn, _params) do
    changeset = Movies.change_movie(%Movie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movie" => movie_params}) do
    case Movies.create_movie(movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    changeset = Movies.change_movie(movie)
    render(conn, "edit.html", movie: movie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Movies.get_movie!(id)

    case Movies.update_movie(movie, movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie updated successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", movie: movie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    {:ok, _movie} = Movies.delete_movie(movie)

    conn
    |> put_flash(:info, "Movie deleted successfully.")
    |> redirect(to: Routes.movie_path(conn, :index))
  end

  def add_post(conn, %{"post" => post_params, "movie_id" => movie_id}) do
    user = current_user(conn)

    movie =
      movie_id
      |> Movies.get_movie!()
      |> Repo.preload([:posts])

    case validate_prohibited_words(post_params["body"]) do
      {:ok, validated_params} ->
        case Movies.add_post(movie_id, validated_params, user.id) do
          {:ok, _post} ->
            conn
            |> put_flash(:info, "Added post!")
            |> redirect(to: Routes.movie_path(conn, :show, movie))

          {:error, _error} ->
            conn
            |> put_flash(:error, "Oops! Couldn't add post!")
            |> redirect(to: Routes.movie_path(conn, :show, movie))
        end

      {:error, error_message} ->
        conn
        |> put_flash(:error, error_message)
        |> redirect(to: Routes.movie_path(conn, :show, movie))
    end
  end

  def show(conn, %{"id" => id}) do
    movie =
      id
      |> Movies.get_movie!()
      |> Repo.preload([:posts])

    changeset = Post.changeset(%Post{}, %{})
    render(conn, "show.html", movie: movie, changeset: changeset)
  end
end
