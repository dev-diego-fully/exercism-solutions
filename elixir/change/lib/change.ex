defmodule Change do
  # Initial configuration of a change map.
  @initial_changes [{0, []}] |> Enum.into(%{})
  # Error when changing an amount is impossible
  @cant_change {:error, "cannot change"}

  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """
  @spec generate([integer], integer) :: {:ok, [integer]} | {:error, String.t()}
  def generate(coins, target)

  # Impossible to change to negative values
  def generate(_, target) when target < 0,
    do: @cant_change

  # Change to zero is trivial: nothing
  def generate(_, 0),
    do: {:ok, []}

  # Initializes the generation function with TCO
  def generate(coins, target),
    do: do_generate(@initial_changes, coins |> Enum.sort(), target, 0)

  # Type that stores an integer as a key and the best change
  # for that integer as a value.
  @type changes_map :: %{optional(integer) => [integer]}

  # A pair containing an amount and change for that amount.
  @type value_and_change :: {integer, [integer]}

  defguardp is_smaller(a, b) when length(a) < length(b)

  # Solves the change problem recursively and using TCO.
  @spec do_generate(changes_map, [integer], integer, integer) ::
          {:ok, [integer]} | {:error, String.t()}
  defp do_generate(changes, coins, target, current_value)

  # Base case: finally reached the target value. Return change
  # if there is any.
  defp do_generate(changes, _, target, target) do
    case changes[target] do
      nil -> @cant_change
      change -> {:ok, change}
    end
  end

  # Main case. Adds one coin each from the current amount,
  # creating change for future amounts. Clears the value stored
  # in the current case.
  defp do_generate(changes, coins, target, current_value) do
    case changes[current_value] do
      nil ->
        changes
        |> do_generate(coins, target, current_value + 1)

      change ->
        {current_value, change}
        |> add_coins_to_change(coins)
        |> Enum.reduce(changes, &add_change_to_changes/2)
        |> clean_change_for(current_value)
        |> do_generate(coins, target, current_value + 1)
    end
  end

  # For currency in the currency list, returns a new change value
  # equal to the original change value after adding this currency to it.
  @spec add_coins_to_change(value_and_change, [integer]) :: Stream.t(value_and_change)
  defp add_coins_to_change({value, change}, coins) do
    coins
    |> Stream.map(fn coin -> {value + coin, [coin | change]} end)
  end

  # Adds a new change for the value passed to the change map. However,
  # it only doesthis if the new change is better than the old change
  # (has fewer coins).
  @spec add_change_to_changes(value_and_change, changes_map) :: changes_map
  defp add_change_to_changes({value, change}, changes) do
    case changes[value] do
      nil ->
        changes |> Map.put(value, change)

      old_change when is_smaller(old_change, change) ->
        changes

      _ ->
        changes |> Map.put(value, change)
    end
  end

  # Removes the change for the passed value from the change map
  # (freeing up memory).
  @spec clean_change_for(changes_map, integer) :: changes_map
  defp clean_change_for(changes, change),
    do: changes |> Map.delete(change)
end
