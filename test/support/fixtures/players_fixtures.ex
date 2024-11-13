defmodule ScoreKeeper.PlayersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ScoreKeeper.Players` context.
  """

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> ScoreKeeper.Players.create_player()

    player
  end
end
