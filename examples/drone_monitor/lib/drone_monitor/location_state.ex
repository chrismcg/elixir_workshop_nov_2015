defmodule DroneMonitor.LocationState do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def update_with_entry(entry) do
    GenServer.cast(__MODULE__, {:entry, entry})
  end

  def current do
    GenServer.call(__MODULE__, :current)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:entry, entry}, state) do
    state = Map.update(state, entry.id, entry, fn(current_entry) ->
      if entry.timestamp > current_entry.timestamp do
        entry
      else
        current_entry
      end
    end)
    {:noreply, state}
  end

  def handle_call(:current, _caller, state) do
    {:reply, state, state}
  end
end
