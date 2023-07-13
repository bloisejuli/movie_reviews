defmodule MovieReviewsWeb.ValidationHelpers do
  @prohibited_words [
    "fuck",
    "imdb",
    "shit",
    "pussy",
    "ass",
    "dumb",
    "bitch",
    "nigga",
    "dick",
    "whore"
  ]

  def validate_prohibited_words(content) do
    case Enum.find(@prohibited_words, &String.contains?(String.downcase(content), &1)) do
      nil -> {:ok, content}
      _ -> {:error, "Contains forbidden words"}
    end
  end
end
