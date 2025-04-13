defmodule KitchenCalculator do
  @type unit :: :milliliter | :cup | :fluid_once | :teaspoon | :tablespoon
  @type measure :: {unit(), number()}

  @conversion_rate %{
    cup: 240,
    fluid_ounce: 30,
    teaspoon: 5,
    tablespoon: 15
  }

  @doc """
  Gets the volume value of the given measure.
  """
  @spec get_volume(measure()) :: number()
  def get_volume({_, volume}),
    do: volume

  @doc """
  Converts the given measure to a measure in milliliters.
  """
  @spec to_milliliter(measure()) :: measure()
  def to_milliliter({:milliliter, _} = volume_pair),
    do: volume_pair

  def to_milliliter({unit, volume}),
    do: {:milliliter, volume * @conversion_rate[unit]}

  @doc """
  Converts a measure given in milliliters to a measure in
  the given unit.
  """
  @spec from_milliliter(measure(), unit()) :: measure()
  def from_milliliter({:milliliter, _} = volume_pair, :milliliter),
    do: volume_pair

  def from_milliliter({_, volume}, unit),
    do: {unit, volume / @conversion_rate[unit]}

  @doc """
  Converts a measurement given in any unit to the given unit.
  """
  @spec convert(measure(), unit()) :: measure()
  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
