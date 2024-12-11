defmodule ScoreKeeper.ScoresTest do
  use ScoreKeeper.DataCase

  alias ScoreKeeper.Scores

  describe "scores" do
    alias ScoreKeeper.MatchesFixtures
    alias ScoreKeeper.PlayersFixtures
    alias ScoreKeeper.Scores.Score

    import ScoreKeeper.ScoresFixtures

    @invalid_attrs %{score: nil}

    test "get_match_scores/1 returns all scores for match_ids" do
      score = score_fixture()
      assert Scores.get_match_scores([score.match_id]) == [score]
    end

    test "create_score/1 with valid data creates a score" do
      match_id = MatchesFixtures.match_fixture().id
      player_id = PlayersFixtures.player_fixture().id

      valid_attrs = %{player_id: player_id, match_id: match_id, score: 42}

      assert {:ok, %Score{} = score} = Scores.create_score(valid_attrs)

      assert score.score == 42
      assert score.match_id == match_id
      assert score.player_id == player_id
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scores.create_score(@invalid_attrs)
    end

    test "new_score/1 with valid data builds a Score entity." do
      assert %Score{match_id: 1} = Scores.new_score(1)
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      update_attrs = %{score: 24}

      assert {:ok, %Score{} = score} = Scores.update_score(score, update_attrs)
      assert score.score == 24
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = Scores.update_score(score, @invalid_attrs)
      assert score == Scores.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = Scores.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> Scores.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = Scores.change_score(score)
    end
  end
end
