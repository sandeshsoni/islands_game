defmodule IslandsEngine.Board do
  alias __MODULE__
  alias IslandsEngine.{Island}

  def new do
    %{}
  end

  # def position_island(board, island, island_type, coordinate) do
  def position_island(board, key, island = %Island{}) do
    case overlaps_existing?(board, key, island) do
      false -> Map.put(board, key, island)
      true -> {:error, :overlaps}
    end
  end

  def overlaps_existing?(board, new_key, new_island) do
    Enum.any?(board, fn{ key, island } -> key != new_key
      and Island.overlaps?(island, new_island)
    end)
  end

  def all_islands_placed?(board) do
    Enum.all?(Island.types, &Map.has_key?(board,&1))
  end

  defp check_win(board) do
    all_islands_on(board)
    |> all_islands_forested?
  end

  defp all_islands_on(board) do
    Enum.values(board)
  end

  defp all_islands_forested?(islands) do
    Enum.all?(islands, &Island.forested?(&1))
  end

  # {hit_or_miss, island, win_no_win, board}
  def guess(board, coordinate) do
  end

end
