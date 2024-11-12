defmodule ScoreKeeper.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :played_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
