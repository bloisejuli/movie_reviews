defmodule MovieReviews.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :rating, :integer
    field :movie_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:rating, :body, :movie_id])
    |> validate_required([:rating, :body, :movie_id])
  end
end
