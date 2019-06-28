defmodule IslandsEngine.IslandTest do
  use ExUnit.Case

  alias IslandsEngine.{Island, Coordinate}

  test "create valid Island type" do
    {:ok, coordinate} = Coordinate.new(1,1)
    {:ok, island} = Island.new(:square, coordinate)

    assert {:ok, _} = Island.new(:square, coordinate)
    assert {:error, _} = Island.new(:rectangle, coordinate)
  end

  test "not create island when coordinate at right corner" do
    {:ok, coordinate} = Coordinate.new(10,1)
    assert {:error, _message} = Island.new(:square, coordinate)
  end

  test "created island contains starting coordinate" do
    {:ok, coordinate} = Coordinate.new(1,1)
    {:ok, island} = Island.new(:square, coordinate)

    assert MapSet.member?(island.coordinates,coordinate)
  end

end
