defmodule MovieReviews.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :rating, :integer
      add :body, :text
      add :movie_id, references(:movies, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:movie_id])
  end
end
