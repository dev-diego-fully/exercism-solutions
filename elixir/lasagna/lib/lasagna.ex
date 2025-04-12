defmodule Lasagna do
  @cooking_time 40
  @preparation_time_per_layer 2
  @alarm_message "Ding!"
  @min_valid_time 0

  @doc """
  Returns the amount of time in minutes that the lasagna is expected
  to be in the oven.
  """
  @spec expected_minutes_in_oven() :: integer
  def expected_minutes_in_oven(),
    do: @cooking_time

  @doc """
  Returns the amount of time in minutes that the lasagna needs to remain
  in the oven given the amount of minutes passed.
  """
  @spec remaining_minutes_in_oven(integer) :: integer
  def remaining_minutes_in_oven(passed_minutes) do
    expected_minutes_in_oven() - passed_minutes
    |> max(@min_valid_time)
  end

  @doc """
  Calculates the preparation time (in minutes) required for a lasagna,
  based on the given number of layers of lasagna.
  """
  @spec preparation_time_in_minutes(integer) :: integer
  def preparation_time_in_minutes(layers_number),
    do: @preparation_time_per_layer * layers_number

  @doc """
  Returns the amount of time (in minutes) worked on the lasagna given
  the number of layers entered and the cooking time entered.
  """
  @spec total_time_in_minutes(integer, integer) :: integer
  def total_time_in_minutes(layers_number, cooking_time) do
    preparation_time =
      layers_number
      |> preparation_time_in_minutes()

    preparation_time + cooking_time
  end

  @doc """
  Returns the alarm message emitted when the lasagna is ready
  """
  @spec alarm() :: String.t()
  def alarm(),
    do: @alarm_message
end
