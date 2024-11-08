defmodule ScoreKeeper.Repo do
  use Ecto.Repo,
    otp_app: :score_keeper,
    adapter: Ecto.Adapters.Postgres
end
