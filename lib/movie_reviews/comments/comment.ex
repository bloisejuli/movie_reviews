defmodule MovieReviews.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :content, :string
    field :user_id, :id
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:user_id, :content, :post_id])
    |> validate_required([:user_id, :content, :post_id])
  end
end
