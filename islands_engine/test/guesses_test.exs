defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case

  alias IslandsEngine.{Coordinate, Guesses}

  test "coordinate added to hits" do
    {:ok, coordinate1} = Coordinate.new(1,1)
    {:ok, coordinate2} = Coordinate.new(2,2)

    guesses = Guesses.new
    updated = Guesses.add(guesses, :hit, coordinate1)
    assert (Enum.member? updated.hits, coordinate1)

  end

  test "miss coordinate" do
    {:ok, coordinate1} = Coordinate.new(1,1)
    {:ok, coordinate2} = Coordinate.new(2,2)

    guesses = Guesses.new

    updated = Guesses.add(guesses, :miss, coordinate1)
    assert (Enum.member? updated.misses, coordinate1)
  end

end
