defmodule MovieReviews.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string

      timestamps()
    end

  end
end
