defmodule MovieReviewsWeb.MovieRandomController do
  use MovieReviewsWeb, :controller
  # alias MovieReviews.Movies
  alias MovieReviews.Posts.Post, as: Post

  def show(conn, %{"movie" => movie}) do
    changeset = Post.changeset(%Post{}, %{})
    render(conn, "show.html", movie: movie, changeset: changeset)
  end
end
