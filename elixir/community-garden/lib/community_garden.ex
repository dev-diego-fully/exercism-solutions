# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    create_plot = fn -> %{last_id: 1, plots: []} end

    case opts do
      [] ->
        Agent.start(create_plot)

      _ ->
        {result, pid, _} = Agent.start(create_plot, opts)
        {result, pid}
    end
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    do_register = fn state ->
      id = state.last_id
      user = %Plot{plot_id: id, registered_to: register_to}

      new_state =
        Map.put(state, :last_id, id + 1)
        |> Map.put(:plots, [user | state.plots])

      {user, new_state}
    end

    Agent.get_and_update(pid, do_register)
  end

  def release(pid, plot_id) do
    do_remove = fn state ->
      remove_by_id = fn plot -> plot.plot_id != plot_id end
      non_removeds = Enum.filter(state.plots, remove_by_id)
      Map.put(state, :plots, non_removeds)
    end

    Agent.update(pid, do_remove)
  end

  def get_registration(pid, plot_id) do
    filter_id = fn %Plot{plot_id: id} -> id == plot_id end
    get_plot = fn state ->
      state.plots
      |> Enum.find({:not_found, "plot is unregistered"}, filter_id)
    end

    Agent.get(pid, get_plot)
  end
end
