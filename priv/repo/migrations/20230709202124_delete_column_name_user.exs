defmodule MovieReviews.Repo.Migrations.DeleteColumnNameUser do
  use Ecto.Migration

  def change do
    alter table("comments") do
      remove :user_id
    end
  end
end
