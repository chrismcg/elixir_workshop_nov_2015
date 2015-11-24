defmodule DroneMonitor.BinaryParser do
  use GenServer

  def start_link(line) do
    GenServer.start_link(__MODULE__, line)
  end

  def init(line) do
    send(self, {:parse_line, line})
    {:ok, nil}
  end

  def handle_info({:parse_line, line}, state) do
    <<
    1 :: size(4),
    id :: size(4),
    timestamp :: size(32),
    x :: size(16),
    y :: size(16),
    z :: size(16),
    dx :: size(8),
    dy :: size(8),
    dz :: size(8)
    >> = line

    entry = %DroneMonitor.LogEntry{
      id: id,
      timestamp: timestamp,
      x: x,
      y: y,
      z: z,
      dx: dx,
      dy: dy,
      dz: dz
    }
    DroneMonitor.LocationState.update_with_entry(entry)
    {:stop, :normal, state}
  end
end
