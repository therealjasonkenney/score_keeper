defmodule ScoreKeeper.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias ScoreKeeper.Matches.Score

  schema "matches" do
    field :played_at, :naive_datetime

    timestamps(type: :utc_datetime)

    has_many :scores, Score
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:played_at])
    |> validate_required([:played_at])
  end
end
