defmodule IslandsEngine.RulesTest do
  use ExUnit.Case
  alias IslandsEngine.Rules

  setup do
    rules = Rules.new()
    {:ok, rules_with_players_added} = Rules.check(rules, :add_player)
    {
      :ok,
      %{
        rules: rules,
        rules_with_players_added: rules_with_players_added
      }
    }
  end

  test "first step add player", state do
    {:ok, new_rules} = Rules.check(state[:rules], :add_player)
    assert new_rules.state == :players_set
    assert new_rules.player1 == :islands_not_positioned
    assert new_rules.player2 == :islands_not_positioned
  end

  test "position islands", state do
    {:ok, new_rules} = Rules.check(state[:rules_with_players_added], :position_islands)
  end

  # describe "turns" do
  #   test "turn after positioned of both players", state do
  #     {:ok, new_rules} = Rules.check(state[:rules_with_players_added], :player1_turn)
  #     assert new_rules.state == :player2_turn
  #   end
  # end

end
