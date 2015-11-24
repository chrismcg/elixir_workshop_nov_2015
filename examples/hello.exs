defmodule Hello do
  def world do
    "Hello World"
  end

  defp sekrit do
    "Not Here"
  end
end

IO.puts Hello.world
IO.puts Hello.sekrit

