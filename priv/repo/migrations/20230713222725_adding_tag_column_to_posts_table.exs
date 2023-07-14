defmodule MovieReviews.Repo.Migrations.AddingTagColumnToPostsTable do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :tag, :string
    end
  end
end
