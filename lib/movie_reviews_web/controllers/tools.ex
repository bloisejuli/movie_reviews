defmodule MovieReviewsWeb.Tools do
  alias MovieReviews.Repo

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

  @tags [
    "bored",
    "funny",
    "friends",
    "lovely"
  ]

  def validate_prohibited_words(content) do
    case Enum.find(@prohibited_words, &String.contains?(String.downcase(content), &1)) do
      nil -> {:ok, content}
      _ -> {:error, "Contains forbidden words"}
    end
  end

  # def update_post_tags_helper(post, content) do
  #  tags = find_matching_tags(content)
  #  updated_post = %{post | tags: tags}
  #  {:ok, updated_post}
  # end

  def find_matching_tags(content) do
    Enum.filter(@tags, &String.contains?(String.downcase(content), &1))
  end

  def get_username(user_id) do
    user = Repo.get(MovieReviews.Users.User, user_id)
    String.split(user.email, "@") |> List.first()
  end
end
