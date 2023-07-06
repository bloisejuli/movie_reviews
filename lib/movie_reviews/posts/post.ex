defmodule MovieReviews.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias MovieReviews.Comments.Comment

  schema "posts" do
    field :body, :string
    field :rating, :integer
    field :movie_id, :id
    field :user_id, :id
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:rating, :body, :movie_id, :user_id])
    |> validate_required([:rating, :body, :movie_id, :user_id])
  end
end
