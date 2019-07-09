defmodule IslandsEngine.RulesTest do
  use ExUnit.Case
  alias IslandsEngine.Rules

  test "first step add player" do
    rules = Rules.new()

    {:ok, new_rules} = Rules.check(rules, :add_player)

    # IO.puts inspect(new_rules)
    assert new_rules.state == :players_set
  end
end
