defmodule IslandsEngine.CoordinateTest do
  use ExUnit.Case
  alias IslandsEngine.Coordinate

  test "valid coordinate" do
    assert Coordinate.new(2,6) == {:ok, %Coordinate{row: 2, col: 6}}
  end

  test "coordinate out of board range" do
    assert Coordinate.new(12,6) == {:error, :invalid_coordinates}
  end

  test "negative coordinate" do
    assert Coordinate.new(2,-6) == {:error, :invalid_coordinates}
  end

end
