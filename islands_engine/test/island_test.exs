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

  test "forested island" do
    {:ok, coordinate1} = Coordinate.new(1,1)
    {:ok, coordinate2} = Coordinate.new(1,2)
    {:ok, coordinate3} = Coordinate.new(2,1)
    {:ok, coordinate4} = Coordinate.new(2,2)

    {:ok, island} = Island.new(:square, coordinate1)

    {:hit, island} = Island.guess(island, coordinate1)
    {:hit, island} = Island.guess(island, coordinate2)
    {:hit, island} = Island.guess(island, coordinate3)
    {:hit, island} = Island.guess(island, coordinate4)

    assert Island.forested?(island)
  end

end
