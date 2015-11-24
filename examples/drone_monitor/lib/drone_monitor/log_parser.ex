defmodule DroneMonitor.LogParser do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:parse_file, logfile}, state) do
    File.stream!(logfile, [], 14) # read 14 bytes at a time
    |> Stream.each(&DroneMonitor.BinaryParserSupervisor.parse_line/1)
    |> Stream.run
    {:noreply, state}
  end
end
