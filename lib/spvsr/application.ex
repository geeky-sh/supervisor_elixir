defmodule Spvsr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Spvsr.Worker.start_link(arg)
      # {Spvsr.Worker, arg},
      {Spvsr.More.Supervisor, [1, 2, 3, 4]},
      {Spvsr.Multiply, 2}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Spvsr.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
