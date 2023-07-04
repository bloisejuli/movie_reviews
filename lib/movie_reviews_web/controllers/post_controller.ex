defmodule MovieReviewsWeb.PostController do
  use MovieReviewsWeb, :controller

  alias MovieReviews.Repo
  alias MovieReviews.Posts
  # alias MovieReviews.Posts.Post
  alias MovieReviews.Movies
  alias MovieReviews.Comments.Comment, as: Comment

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  #  def new(conn, _params) do
  #    changeset = Post.change_post(%Post{})
  #    render(conn, "new.html", changeset: changeset)
  #  end

  def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post =
      post_id
      |> Posts.get_post!()
      |> Repo.preload([:comments])

    case Posts.add_comment(post_id, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Added comment!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, _error} ->
        conn
        |> put_flash(:error, "Oops! Couldn't add comment!")
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
