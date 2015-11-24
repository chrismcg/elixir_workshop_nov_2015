defmodule Upcase do
  def upcase(list) when is_list(list) do
    do_upcase(list, [])
  end

  defp do_upcase([head | tail], results) do
    results = [String.upcase(head) | results]
    do_upcase(tail, results)
  end
  defp do_upcase([], results) do
    Enum.reverse(results)
  end
end

IO.inspect Upcase.upcase(["hello", "to", "everyone"])
