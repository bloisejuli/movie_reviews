defmodule MovieReviewsWeb.Router do
  use MovieReviewsWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", MovieReviewsWeb do
    pipe_through([:browser])

    get("/", PageController, :index)
  end

  scope "/", MovieReviewsWeb do
    pipe_through([:browser, :protected])

    resources("/movies", MovieController) do
      post "/post", MovieController, :add_post
    end

    resources("/posts", PostController) do
      post "/comment", PostController, :add_comment
    end

    get "/movie_random", MovieRandomController, :show
  end

  # Other scopes may use custom stacks.Reviews:
  # scope "/api", MovieReviewsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)
      live_dashboard("/dashboard", metrics: MovieReviewsWeb.Telemetry)
    end
  end
end
