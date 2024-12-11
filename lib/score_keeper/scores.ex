defmodule ScoreKeeper.Scores do
  @moduledoc """
  The Scores context.
  """

  alias ScoreKeeper.Repo
  alias ScoreKeeper.Scores.Score

  import ScoreKeeper.Scores.ScoreQuery, only: [match_scores: 1]

  @typedoc "A player's score within a game match."
  @type score() :: Score.t()

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking score changes.

  ## Examples

      iex> change_score(score)
      %Ecto.Changeset{data: %Score{}}

  """
  @spec change_score(score()) :: Ecto.Changeset.t()
  def change_score(%Score{} = score, attrs \\ %{}) do
    Score.changeset(score, attrs)
  end

  @doc """
  Creates a score.

  ## Examples

      iex> create_score(%{score: 1, player_id: 1, match_id: 1})
      {:ok, %Score{}}

      iex> create_score(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_score(map()) :: {:ok, score()} | {:error | Ecto.Changeset.t()}
  def create_score(attrs \\ %{}) do
    %Score{}
    |> Score.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a score.

  ## Examples

      iex> delete_score(score)
      {:ok, %Score{}}

      iex> delete_score(score)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_score(score()) :: {:ok, score()} | {:error, Ecto.Changeset.t()}
  def delete_score(%Score{} = score) do
    Repo.delete(score)
  end

  @doc """
  Fetches all scores for the match_ids provided.

  ## Examples

    iex> get_match_scores([123])
    [%Score{},...]

  """
  @spec get_match_scores(list(pos_integer())) :: list(score())
  def get_match_scores(match_ids)
      when is_list(match_ids) and length(match_ids) > 0 do
    match_scores(match_ids)
    |> Repo.all()
  end

  # No need to hit the DB if no match_ids are provided.
  def get_match_scores([]), do: []

  @doc """
  Gets a single score.

  Raises `Ecto.NoResultsError` if the Score does not exist.

  ## Examples

      iex> get_score!(123)
      %Score{}

      iex> get_score!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_score!(pos_integer()) :: score()
  def get_score!(id), do: Repo.get!(Score, id)

  @doc """
  Builds a new score struct for a match.
  """
  @spec new_score(pos_integer()) :: score()
  def new_score(match_id) when is_number(match_id) do
    %Score{match_id: match_id}
  end

  @doc """
  Updates a score.

  ## Examples

      iex> update_score(score, %{score: 42})
      {:ok, %Score{}}

      iex> update_score(score, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_score(score(), map()) :: {:ok, score()} | {:error, Ecto.Changeset.t()}
  def update_score(%Score{} = score, attrs) do
    score
    |> Score.changeset(attrs)
    |> Repo.update()
  end
end
