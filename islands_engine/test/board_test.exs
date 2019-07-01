defmodule IslandsEngine.BoardTest do
  use ExUnit.Case
  alias IslandsEngine.{Board, Coordinate, Island}

  test "create new board" do
    assert Board.new
  end

  test "allow place an island in board" do
    {:ok, coordinate1} = Coordinate.new(1,1)
    {:ok, square_island} = Island.new(:square, coordinate1)
    assert Board.position_island(Board.new, :square, square_island)
  end

  test "dont allow to place intersecting islands" do
    {:ok, coordinate1} = Coordinate.new(1,1)
    {:ok, square_island} = Island.new(:square, coordinate1)
    {:ok, coordinate2} = Coordinate.new(2,2)
    {:ok, coordinate3} = Coordinate.new(3,3)
    {:ok, dot_island} = Island.new(:dot, coordinate2)
    {:ok, square_island2} = Island.new(:square, coordinate3)

    board = Board.position_island(Board.new, :square, square_island)

    {:error, _} = Board.position_island(board, :dot, dot_island)
  end

  test "all islands positioned" do
    {:ok, coordinate1} = Coordinate.new(1,1)
    {:ok, square_island} = Island.new(:square, coordinate1)
    {:ok, coordinate2} = Coordinate.new(5,2)
    {:ok, dot_island} = Island.new(:dot, coordinate2)
    {:ok, coordinate3} = Coordinate.new(3,3)
    {:ok, l_island} = Island.new(:square, coordinate3)
    {:ok, coordinate4} = Coordinate.new(6,2)
    {:ok, atoll_island} = Island.new(:atoll, coordinate4)
    {:ok, coordinate5} = Coordinate.new(6,5)
    {:ok, s_shape_island} = Island.new(:s_shape, coordinate5)

    board = Board.new
    |> Board.position_island(:square, square_island)
    |> Board.position_island(:l_shape, l_island)
    |> Board.position_island(:dot, dot_island)
    |> Board.position_island(:atoll, atoll_island)
    |> Board.position_island(:s_shape, s_shape_island)
    assert Board.all_islands_placed?(board)
  end

end
