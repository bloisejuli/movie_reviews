defmodule MovieReviewsWeb.PostController do
  use MovieReviewsWeb, :controller

  import Pow.Plug
  alias MovieReviews.Repo
  alias MovieReviews.Posts
  alias MovieReviews.Movies
  alias MovieReviews.Comments.Comment, as: Comment
  import MovieReviewsWeb.Tools

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  #  def new(conn, _params) do
  #    changeset = Post.change_post(%Post{})
  #    render(conn, "new.html", changeset: changeset)
  #  end

  def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    user = current_user(conn)

    post =
      post_id
      |> Posts.get_post!()
      |> Repo.preload([:comments])

    case validate_prohibited_words(comment_params["content"]) do
      {:ok, _} ->
        case Posts.add_comment(post_id, comment_params, user.id) do
          {:ok, _comment} ->
            conn
            |> put_flash(:info, "Added comment!")
            |> redirect(to: Routes.post_path(conn, :show, post))

          {:error, _error} ->
            conn
            |> put_flash(:error, "Oops! Couldn't add comment!")
            |> redirect(to: Routes.post_path(conn, :show, post))
        end

      {:error, error_message} ->
        conn
        |> put_flash(:error, error_message)
        |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end

  def show(conn, %{"id" => id}) do
    post =
      id
      |> Posts.get_post!()
      |> Repo.preload([:comments])

    movie = Movies.get_movie!(post.movie_id)
    title = movie.title
    changeset = Comment.changeset(%Comment{}, %{})
    render(conn, "show_post.html", post: post, title: title, changeset: changeset)
  end
end
