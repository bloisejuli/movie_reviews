defmodule MovieReviews.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  alias MovieReviews.Posts.Post

  schema "movies" do
    field :title, :string
    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
