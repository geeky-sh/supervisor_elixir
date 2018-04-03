defmodule Spvsr.Stack do
  use GenServer

  def start_link(list) do
    GenServer.start_link(__MODULE__, list, name: __MODULE__)
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

  def handle_call(:pop, _from, [head | tail]), do: {:reply, head, tail}
  def handle_call(:pop, _from, []), do: {:stop, "Stack is empty", []}

  def handle_cast({:push, {:bye, msg}}, list), do: {:stop, msg, list}
  def handle_cast({:push, n}, list) when n > 10, do: {:stop, :shutdown, list}
  def handle_cast({:push, n}, list), do: {:noreply, [n | list]}

  def terminate(reason, state) do
    IO.puts("I m terminating #{IO.inspect reason} #{IO.inspect state} ")
    :ok
  end
end
