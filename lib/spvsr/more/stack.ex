defmodule Spvsr.More.Stack do
  use GenServer

  def start_link(func) do
    GenServer.start_link(__MODULE__, func.(), name: __MODULE__)
  end

  def init(args) do
    {:ok, args}
  end

  def shutdown(msg \\ "No msg received") do
    GenServer.cast(__MODULE__, {:push, {:bye, msg}})
  end

  def push(n) do
    GenServer.cast(__MODULE__, {:push, n})
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def handle_call(:pop, _from, [head | tail]), do: {:reply, head, tail}
  def handle_call(:pop, _from, []) do
    Spvsr.More.Stash.save_value []
    {:stop, "Stack is empty", []}
  end
  def handle_call(:get, _from, list), do: {:reply, list, list}


  def handle_cast({:push, {:bye, msg}}, list), do: {:stop, msg, list}
  def handle_cast({:push, n}, list) when n > 10, do: {:stop, :shutdown, list}
  def handle_cast({:push, n}, list), do: {:noreply, [n | list]}

  def terminate(reason, state) do
    IO.puts("I m terminating #{IO.inspect reason} #{IO.inspect state} ")
    :ok
  end
end
