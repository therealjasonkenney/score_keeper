defmodule ScoreKeeper.ScoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ScoreKeeper.Scores` context.
  """

  alias ScoreKeeper.MatchesFixtures
  alias ScoreKeeper.PlayersFixtures

  @doc """
  Generate a score.
  """
  def score_fixture(attrs \\ %{}) do
    match_id =
      MatchesFixtures.match_fixture()
      |> Map.get(:id)

    player_id =
      PlayersFixtures.player_fixture()
      |> Map.get(:id)

    {:ok, score} =
      attrs
      |> Enum.into(%{
        "match_id" => match_id,
        "player_id" => player_id,
        "score" => 42
      })
      |> ScoreKeeper.Scores.create_score()

    score
  end
end
