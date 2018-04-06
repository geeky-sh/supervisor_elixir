defmodule Spvsr.More.Supervisor do
  use Supervisor

  def start_link(initial) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, initial, name:  __MODULE__)

    start_workers(sup, initial)
    result
  end

  def start_workers(sup, initial) do
    Supervisor.start_child(sup, worker(Spvsr.More.Stash, [initial]))
    Supervisor.start_child(sup, worker(Spvsr.More.Stack, [fn -> Spvsr.More.Stash.get_value end]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
