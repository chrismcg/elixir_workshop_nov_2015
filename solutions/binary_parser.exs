defmodule LogEntry do
  defstruct [:id, :timestamp, :x, :y, :z, :dx, :dy, :dz]
end

defmodule BinaryParser do
  # Return a list of filled in LogEntry structs
  def parse_line(line) do
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

    %LogEntry{
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

defmodule LogParser do
  def parse(logfile) do
    File.stream!(logfile, [], 14) # read 14 bytes at a time
    |> Enum.map(fn(line) -> BinaryParser.parse_line(line) end)
    |> print_last_positions
  end

  def print_last_positions(log_entries) do
    last_known_positions = Enum.reduce(log_entries, %{}, fn(entry, results) ->
      %{timestamp: ts, x: x, y: y, z: z} = entry
      Map.put(results, entry.id, {ts, x, y, z})
    end)
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

  # test "what happens with bad data" do
  #   positions = LogParser.parse("./example_data/bad.log")
  #   assert positions == %{
  #     1 => {1_450_000_009, 10, 10, 10},
  #     2 => {1_450_000_009, 20, 20, 20},
  #     3 => {1_450_000_009, 30, 30, 30}
  #   }
  # end
end
