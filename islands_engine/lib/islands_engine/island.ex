defmodule IslandsEngine.Island do
  alias __MODULE__
  alias IslandsEngine.{Coordinate, Guesses}

  @nforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  # def new do
  #   %Island{coordinates: MapSet.new(), hit_coordinates: MapSet.new()}
  # end

  def new(type, %Coordinate{} = upper_left) do
    with [_|_] = offsets <- offsets(type),
         %MapSet{} = coordinates <- add_coordinates(offsets, upper_left)
      do
      {:ok, %Island{coordinates: coordinates, hit_coordinates: MapSet.new()}}
      else
        error -> error
    end
  end

  defp offsets(:square), do: [{0,0}, {0,1}, {1,0}, {1,1}]
  defp offsets(:atoll), do: [{0,0}, {0,1}, {1,1}, {2,1}, {2,0}]
  defp offsets(:dot), do: [{0,0}]
  defp offsets(:l_shape), do: [{0,0},{1,0},{2,0},{2,1}]
  defp offsets(:s_shape), do: [{0,1},{0,2},{1,0},{1,1}]
  defp offsets(_), do: {:error, :invalid_island_type}

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

  def overlaps?(existing_island, new_island) do
    not MapSet.disjoint?(existing_island.coordinates, new_island.coordinates)
  end

  def guess(island, coordinate) do
    case MapSet.member?(island.coordinates, coordinate) do
      true ->
        hit_coordinates = MapSet.put(island.hit_coordinates, coordinate)
        {:hit, %{island | hit_coordinates: hit_coordinates} }
      false -> :miss
    end
  end

end
