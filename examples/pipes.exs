defmodule Pipes do
  def process(string) do
    upper = String.upcase(string)
    parts = String.split(upper, "Z")
    Enum.count(parts)
  end

  def process_with_pipes(string) do
    string
    |> String.upcase
    |> String.split("Z")
    |> Enum.count
  end
end
