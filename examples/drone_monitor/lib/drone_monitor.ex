defmodule DroneMonitor do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(DroneMonitor.LogParser, []),
      worker(DroneMonitor.LocationState, []),
      supervisor(DroneMonitor.BinaryParserSupervisor, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DroneMonitor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def parse(logfile) do
    GenServer.cast(DroneMonitor.LogParser, {:parse_file, logfile})
  end
end
