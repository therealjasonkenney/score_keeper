defmodule ScoreKeeper.Scores.ScoreQuery do
  @moduledoc false

  import Ecto.Query, warn: false

  alias ScoreKeeper.Scores.Score

  @doc false
  @spec match_scores(list(pos_integer())) :: Ecto.Query.t()
  def match_scores(match_ids)
      when is_list(match_ids) and
             length(match_ids) > 0 do
    from s in Score,
      where: s.match_id in ^match_ids,
      order_by: [desc: s.score]
  end
end
