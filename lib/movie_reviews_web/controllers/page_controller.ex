defmodule MovieReviewsWeb.PageController do
  use MovieReviewsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
