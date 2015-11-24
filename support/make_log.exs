defmodule LogEntry do
  defstruct [:id, :timestamp, :x, :y, :z, :dx, :dy, :dz]
end

defmodule Output do
  def line_for_entry(entry, version \\ 1) do
    <<
    version :: size(4),
    entry.id :: size(4),
    entry.timestamp :: size(32),
    entry.x :: size(16),
    entry.y :: size(16),
    entry.z :: size(16),
    entry.dx :: size(8),
    entry.dy :: size(8),
    entry.dz :: size(8)
    >>
  end

  def output_good_log(filename) do
    data = entries
    |> Enum.map(&line_for_entry/1)
    |> Enum.join("")

    File.write!(filename, data)
  end

  def entries do
    [
      %LogEntry{id: 1, timestamp: 1_450_000_000, x:  1, y:  1, z:  1, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_001, x:  2, y:  2, z:  2, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_000, x: 11, y: 11, z: 11, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_000, x: 21, y: 21, z: 21, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_001, x: 22, y: 22, z: 22, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_001, x: 12, y: 12, z: 12, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_002, x:  3, y:  3, z:  3, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_002, x: 23, y: 23, z: 23, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_002, x: 13, y: 13, z: 13, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_003, x:  4, y:  4, z:  4, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_003, x: 14, y: 14, z: 14, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_003, x: 24, y: 24, z: 24, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_004, x: 15, y: 15, z: 15, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_004, x:  5, y:  5, z:  5, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_004, x: 25, y: 25, z: 25, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_005, x:  6, y:  6, z:  6, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_005, x: 16, y: 16, z: 16, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_005, x: 26, y: 26, z: 26, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_006, x:  7, y:  7, z:  7, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_006, x: 17, y: 17, z: 17, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_007, x: 18, y: 18, z: 18, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_007, x:  8, y:  8, z:  8, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_006, x: 27, y: 27, z: 27, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_008, x: 19, y: 19, z: 19, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_008, x:  9, y:  9, z:  9, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_007, x: 28, y: 28, z: 28, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 1, timestamp: 1_450_000_009, x: 10, y: 10, z: 10, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_008, x: 29, y: 29, z: 29, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 2, timestamp: 1_450_000_009, x: 20, y: 20, z: 20, dx: 1, dy: 1, dz: 1},
      %LogEntry{id: 3, timestamp: 1_450_000_009, x: 30, y: 30, z: 30, dx: 1, dy: 1, dz: 1}
    ]
  end
end
