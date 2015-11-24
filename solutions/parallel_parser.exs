defmodule LogEntry do
  defstruct [:id, :timestamp, :x, :y, :z, :dx, :dy, :dz]
end

defmodule BinaryParser do
  # Return a list of filled in LogEntry structs
  def parse_line(line, location_state) do
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

    send location_state, %LogEntry{
      id: id,
      timestamp: timestamp,
      x: x,
      y: y,
      z: z,
      dx: dx,
      dy: dy,
      dz: dz
    }
  end
end

defmodule FileReader do
  def parse(logfile, location_state) do
    File.stream!(logfile, [], 14) # read 14 bytes at a time
    |> Stream.each(fn(line) -> spawn(BinaryParser, :parse_line, [line, location_state]) end)
    |> Stream.run
  end
end

defmodule LocationState do
  def start do
    loop(%{})
  end

  def loop(state) do
    receive do
      {:state, caller} ->
        send(caller, state)
        loop(state)
      entry ->
        state = update_state(entry)
        loop(state)
    end
  end

  defp update_state(entry) do
    Map.update(state, entry.id, entry, fn(current_entry) ->
      if entry.timestamp > current_entry.timestamp do
        entry
      else
        current_entry
      end
    end)
  end
end

defmodule LogParser do
  def parse(logfile) do
    location_state = spawn(LocationState, :start, [])
    spawn(FileReader, :parse, [logfile, location_state])

    # RACE CONDITION!
    :timer.sleep(1000)

    send(location_state, {:state, self})
    receive do
      log_entries ->
        IO.inspect log_entries
        print_last_positions(log_entries)
    end
  end

  def print_last_positions(last_positions) do
    last_known_positions = Enum.map(last_positions, fn({id, entry}) ->
      {id, {entry.timestamp, entry.x, entry.y, entry.z}}
    end)
    |> Enum.into(%{})
    IO.inspect last_known_positions
  end
end

ExUnit.start

defmodule LogParserTest do
  use ExUnit.Case, async: true

  test "returns map containing tuple of last known positions correctly" do
    positions = LogParser.parse("./example_data/good.log")
    assert positions == %{
      1 => {1_450_000_009, 10, 10, 10},
      2 => {1_450_000_009, 20, 20, 20},
      3 => {1_450_000_009, 30, 30, 30}
    }
  end

  test "what happens with bad data" do
    positions = LogParser.parse("./example_data/bad.log")
    assert positions == %{
      1 => {1_450_000_009, 10, 10, 10},
      2 => {1_450_000_009, 20, 20, 20},
      3 => {1_450_000_009, 30, 30, 30}
    }
  end
end
