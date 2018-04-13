defmodule Spvsr.Multiply do
  use GenServer

  def start_link(no) do
    GenServer.start_link(__MODULE__, no, name: __MODULE__)
  end

  def init(args) do
    {:ok, args}
  end

  def next_number do
    GenServer.call(__MODULE__, :get_next)
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def multiply_by(num) do
    GenServer.cast(__MODULE__, {:multiply_by, num})
  end

  def handle_call(:get_next, _from, state) do
    {:reply, state*2, state*2}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:multiply_by, num}, state) do
    {:noreply, state*num}
  end
end
