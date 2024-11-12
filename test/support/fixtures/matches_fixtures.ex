defmodule ScoreKeeper.MatchesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ScoreKeeper.Matches` context.
  """

  @doc """
  Generate a match.
  """
  def match_fixture(attrs \\ %{}) do
    {:ok, match} =
      attrs
      |> Enum.into(%{
        played_at: ~N[2024-11-11 22:59:00]
      })
      |> ScoreKeeper.Matches.create_match()

    match
  end
end
