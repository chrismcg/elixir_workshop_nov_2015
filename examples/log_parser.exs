defmodule LogEntry do
  defstruct [:id, :timestamp, :x, :y, :z, :dx, :dy, :dz]
end

defmodule BinaryParser do
  def parse_line(line) do
    <<
      _version :: 3,
      id :: 5,
      timestamp :: 32,
      x :: 16,
      y :: 16,
      z :: 16,
      dx :: 8,
      dy :: 8,
      dz :: 8
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
    File.stream!(logfile)
    |> Stream.map(fn(line) -> String.rstrip(line, ?\n) end)
    |> Enum.map(fn(line) -> BinaryParser.parse_line(line) end)
    |> print_last_positions
  end

  def print_last_positions(log_entries) do
    last_known_positions = Enum.reduce(log_entries, %{}, fn(entry, results) ->
      %{x: x, y: y, z: z} = entry
      Map.put(results, entry.id, {x, y, z})
    end)
    IO.inspect last_known_positions
  end
end
