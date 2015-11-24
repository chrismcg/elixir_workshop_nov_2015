defmodule DroneMonitor.BinaryParserSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def parse_line(line) do
    Supervisor.start_child(__MODULE__, [line])
  end

  def init(_) do
    children = [
      worker(DroneMonitor.BinaryParser, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
