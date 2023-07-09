defmodule Api do
  @base_url "https://api.themoviedb.org/3"
  @api_key "e1ad0f689f3ac23b2469621fb3f23b02"

  def get_popular_movies() do
    url = "#{@base_url}/movie/popular?api_key=#{@api_key}"
    response = HTTPoison.get(url)

    case response.status_code do
      200 ->
        {:ok, response.body}

      _ ->
        {:error, "Error al obtener los detalles de la película"}
    end
  end
end
