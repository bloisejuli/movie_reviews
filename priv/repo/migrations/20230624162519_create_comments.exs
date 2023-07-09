defmodule MovieReviews.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :user_id, references(:users, on_delete: :nothing)
      add :content, :text
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:post_id])
  end
end
