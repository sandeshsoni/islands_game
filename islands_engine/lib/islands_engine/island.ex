defmodule IslandsEngine.Island do
  alias __MODULE__
  alias IslandsEngine.{Coordinate, Guesses}

  @nforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  def new do
    %Island{coordinates: MapSet.new(), hit_coordinates: MapSet.new()}
  end

  defp offset(:square), do: [{0,0}, {0,1}, {1,0}, {1,1}]
  defp offset(:atoll), do: [{0,0}, {0,1}, {1,1}, {2,1}, {2,0}]
  defp offset(:dot), do: [{0,0}]
  defp offset(:l_shape), do: [{0,0},{1,0},{2,0},{2,1}]
  defp offset(:s_shape), do: [{0,1},{0,2},{1,0},{1,1}]
  defp offset(_), do: {:error, :invalid_offset}

  def add_coordinates(offsets, upper_left) do
    Enum.reduce_while(offsets, MapSet.new(), fn offset, accu ->
      add_coordinate(accu, upper_left, offset)
    end)
  end

  def add_coordinate(coordinates, %Coordinate{row: row, col: col}, {row_offset, col_offset}) do
    case Coordinate.new(row + row_offset, col + col_offset) do
      {:ok, coordinate} ->
        {:cont, MapSet.put(coordinates, coordinate)}
      {:error, :invalid_coordinates} ->
        {:halt, {:error, :invalid_coordinates}}
    end
  end

end
