defmodule Parser do
  # TODO
end

ExUnit.start

defmodule ParserTest do
  use ExUnit.Case, async: true

    test "parses greeting correctly" do
    assert Parser.parse("GREETING: Hello") == "Hello"
  end

  test "parses name correctly" do
    assert Parser.parse("NAME: Jose") == "Jose"
  end

  test "parses unknown string correctly" do
    assert Parser.parse("foo") == :unknown
  end
end

ExUnit.run
