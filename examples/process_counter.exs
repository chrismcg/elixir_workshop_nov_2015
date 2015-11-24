defmodule ProcessCounter do
  def loop(count) do
    receive do
      :increment ->
        IO.puts "Updating counter"
        loop(count + 1)
      :count ->
        IO.puts "Count: #{count}"
        loop(count)
      :quit ->
        IO.puts "Quitting with count #{count}"
    after
      2000 ->
        IO.puts "Bored!!"
        loop(count)
    end
  end
end
