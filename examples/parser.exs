defmodule Parser do
  def strings do
    [
      "GREETING: Hello",
      "NAME: Mr Kat"
    ]
  end

  def parse_string("GREETING: " <> greeting) do
    greeting
  end
  def parse_string("NAME: " <> name) do
    name
  end
  def parse_string(_) do
    :unknown
  end

  def parse_list(list) do
    parse(list, [])
  end

  def do_parse_list([head | tail], acc) do
    values = parse_string(head)
    do_parse_list(tail, [values | acc])
  end
  def do_parse_list([], acc) do
    Enum.reverse(acc)
  end
end

# IO.inspect ParseStrings.parse(ParseStrings.strings)
