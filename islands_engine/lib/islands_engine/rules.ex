defmodule IslandsEngine.Rules do
  alias __MODULE__

  defstruct [
    state: :initialized,
    player1: :islands_not_positioned,
    player2: :islands_not_positioned
  ]


  def new do
    %Rules{}
  end

  def check(%Rules{state: :initialized} = rules, :add_player) do
    {:ok, %Rules{rules | state: :players_set}}
  end

  def check(%Rules{state: :players_set} = rules, :position_islands) do
    {:ok, %Rules{rules | state: :islands_positioned}}
  end

  def check(_state, _action) do
    :error
  end

end
