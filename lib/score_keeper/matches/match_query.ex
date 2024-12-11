defmodule ScoreKeeper.Matches.MatchQuery do
  @moduledoc false

  import Ecto.Query, warn: false

  alias ScoreKeeper.Matches.Score
  alias ScoreKeeper.Matches.Match

  @doc false
  @spec all_matches() :: Ecto.Query.t()
  def all_matches() do
    from m in Match, order_by: [desc: m.played_at]
  end

  @doc false
  @spec match_scores(list(pos_integer())) :: Ecto.Query.t()
  def match_scores(match_ids)
      when is_list(match_ids) and
             length(match_ids) > 0 do
    from s in Score,
      join: p in assoc(s, :players),
      on: p.id == s.player_id,
      where: s.match_id in ^match_ids,
      order_by: [desc: s.score],
      preload: [players: p]
  end
end
