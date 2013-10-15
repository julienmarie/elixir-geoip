defmodule Mnesiageoip.Supervisor do
  use Supervisor.Behaviour
  use Amnesia
  use Mnesiageoip.Database

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    Amnesia.Schema.create
    Amnesia.start
    Mnesiageoip.Database.create
    Mnesiageoip.Database.wait


    children = [
      # Define workers and child supervisors to be supervised
      worker(Mnesiageoip.Server, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
