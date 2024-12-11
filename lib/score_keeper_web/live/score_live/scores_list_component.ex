defmodule ScoreKeeperWeb.Live.ScoreLive.ScoresListComponent do
  alias ScoreKeeper.Scores

  use ScoreKeeperWeb, :live_component

  @impl true
  def render(assigns) do
    section_id = "match-#{assigns.match_id}-scores"
    table_id = "match-#{assigns.match_id}-score-table"

    ~H"""
    <section class="scores-table" id={section_id}>
      <h3>Scores</h3>
      <div class="flex-none">
        <.button>Add New Score</.button>
      </div>
      <.table id={table_id} rows={@scores}>
        <:col :let={score} label="player"><%= score.player.name %></:col>
        <:col :let={score} label="score"><%= score.score %></:col>
      </.table>
    </section>
    """
  end

  @impl true
  def update_many(socket_assigns) do
    scores =
      socket_assigns
      |> Enum.map(fn {assigns, _socket} -> assigns.match_id end)
      |> Scores.get_match_scores()
      |> Enum.group_by(& &1.match_id)
      |> Map.values()

    Enum.map(socket_assigns, fn {assigns, socket} ->
      assign(socket, :scores, scores[assigns.match_id])
    end)
  end
end
