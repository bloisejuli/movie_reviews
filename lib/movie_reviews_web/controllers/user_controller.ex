defmodule MovieReviews.Web.UserController do
  use MovieReviewsWeb, :controller
  import Pow.Plug.CurrentUser

  def index(conn, _params) do
    case Pow.Plug.current_user(conn) do
      %Pow.Plug.User{} = user ->
        render(conn, "index.html", user: user)

      nil ->
        render(conn, "index.html")
    end
  end
end
