defmodule ScoreKeeper.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :score, :integer
      add :player_id, references(:players, on_delete: :nothing)
      add :match_id, references(:matches, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:scores, [:player_id])
    create index(:scores, [:match_id])
  end
end
