defmodule MovieReviews.MovieFinder do
  require HTTPoison

  @base_url Application.get_env(:my_app, :base_url)
  @api_key Application.get_env(:my_app, :api_key)

  @genres_list [
    %{"id" => 28, "name" => "Action"},
    %{"id" => 12, "name" => "Adventure"},
    %{"id" => 16, "name" => "Animation"},
    %{"id" => 35, "name" => "Comedy"},
    %{"id" => 80, "name" => "Crime"},
    %{"id" => 99, "name" => "Documentary"},
    %{"id" => 18, "name" => "Drama"},
    %{"id" => 10751, "name" => "Family"},
    %{"id" => 14, "name" => "Fantasy"},
    %{"id" => 36, "name" => "History"},
    %{"id" => 27, "name" => "Horror"},
    %{"id" => 10402, "name" => "Music"},
    %{"id" => 9648, "name" => "Mystery"},
    %{"id" => 10749, "name" => "Romance"},
    %{"id" => 878, "name" => "Science Fiction"},
    %{"id" => 10770, "name" => "TV Movie"},
    %{"id" => 53, "name" => "Thriller"},
    %{"id" => 10752, "name" => "War"},
    %{"id" => 37, "name" => "Western"}
  ]

  def get_genre_list, do: {:ok, @genres_list}

  def get_movies_by_genre(genre_id) do
    genre = Enum.find_value(@genres_list, fn %{"id" => id} -> id == genre_id end)

    case genre do
      nil ->
        {:error, "Género no encontrado"}

      %{name: genre_name} ->
        {:ok, "Películas del género #{genre_name}"}
    end
  end
end
