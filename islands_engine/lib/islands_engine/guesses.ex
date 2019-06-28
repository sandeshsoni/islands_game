defmodule IslandsEngine.Guesses do
  alias __MODULE__

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  def new do
    %Guesses{hits: MapSet.new(), misses: MapSet.new()}
  end

  def add(guesses, :hit, coordinate) do
    update_in(guesses.hits, &MapSet.put(&1,coordinate))
  end

  def add(guesses, :miss, coordinate) do
    update_in(guesses.misses, &MapSet.put(&1,coordinate))
  end

end
