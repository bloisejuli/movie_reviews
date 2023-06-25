defmodule MovieReviews.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :content, :string
    field :name_user, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:name_user, :content, :post_id])
    |> validate_required([:name_user, :content, :post_id])
  end
end
