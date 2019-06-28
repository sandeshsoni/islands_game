defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case

  alias IslandsEngine.{Coordinate, Guesses}

  test "coordinate added to hits" do
    {:ok, coordinate1} = Coordinate.new(1,1)
    {:ok, coordinate2} = Coordinate.new(2,2)

    guesses = Guesses.new
    updated = update_in(guesses.hits, &MapSet.put(&1, coordinate1))
    assert (Enum.member? updated.hits, coordinate1)

    updated = update_in(guesses.hits, &MapSet.put(&1, coordinate2))
    assert (Enum.member? updated.hits, coordinate2)
  end

end
