defmodule Spvsr.More.Stash do
  use GenServer
  require Logger

  def start_link(list) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, list, name: __MODULE__)
  end

  def save_value(value) do
    IO.puts("setting value #{value}")
    GenServer.cast __MODULE__, {:save_value, value}
  end

  def get_value do
    IO.puts("get value")
    GenServer.call __MODULE__, :get_value
  end

  def handle_cast({:save_value, value}, _current_value) do
    {:noreply, value}
  end

  def handle_call(:get_value, _from, current_value) do
    {:reply, current_value, current_value}
  end

  def init(args) do
    {:ok, args}
  end
end
