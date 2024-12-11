defmodule ScoreKeeper.Scores.Score do
  use Ecto.Schema
  import Ecto.Changeset

  alias ScoreKeeper.Players.Player

  schema "scores" do
    field :match_id, :id
    field :player_id, :id
    field :score, :integer

    has_one :player, Player

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:match_id, :player_id, :score])
    |> validate_required([:match_id, :player_id, :score])
  end
end
