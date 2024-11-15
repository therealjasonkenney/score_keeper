defmodule ScoreKeeper.Matches.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :score, :integer
    field :player_id, :id
    field :match_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:score])
    |> validate_required([:score])
  end
end
