defmodule Greeter do
  def greet(name) do
    "Hello #{name}"
  end

  def greet(first_name, last_name) do
    "Hello #{first_name} #{last_name}"
  end
end

IO.puts Greeter.greet("Jose")
IO.puts Greeter.greet("Jose", "Valim")
