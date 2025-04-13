defmodule BirdCount do
  @busy_day 5

  @doc """
  Returns the count of birds seen on the current day
  """
  @spec today([integer()]) :: integer()
  def today([]),
    do: nil

  def today([last_day | _]),
    do: last_day

  @doc """
  Increases the number of birds seen in the current day by 1
  """
  @spec increment_day_count([integer()]) :: [integer()]
  def increment_day_count(days)

  def increment_day_count([]),
    do: [1]

  def increment_day_count([day_count | others_day]),
    do: [day_count + 1 | others_day]

  @doc """
  Returns whether or not there is a day in the day count in which
  no birds were counted (0).
  """
  @spec has_day_without_birds?([integer()]) :: boolean()
  def has_day_without_birds?([]),
    do: false

  def has_day_without_birds?([0 | _]),
    do: true

  def has_day_without_birds?([_ | other_days]),
    do: has_day_without_birds?(other_days)

  @doc """
  Returns the total number of birds counted on all recorded days
  """
  @spec total([integer()]) :: integer()
  def total(list),
    do: do_total(list)

  @doc """
  Returns the number of days in the bird count
  that were considered "busy"
  """
  @spec busy_days([integer()]) :: integer()
  def busy_days(list),
    do: do_busy_days(list)

  # Calculates the total bird count recursively
  @spec do_total([integer()], integer()) :: integer()
  defp do_total(days, count \\ 0)

  # Empty list ends counting
  defp do_total([], total),
    do: total

  # Adds a day's count to the total counted so far
  defp do_total([current | other_days], total),
    do: do_total(other_days, total + current)

  # Counts "busy" days recursively
  @spec do_busy_days([integer()], integer()) :: integer()
  defp do_busy_days(list, count \\ 0)

  # Empty list ends counting
  defp do_busy_days([], count),
    do: count

  # Current day count enough to be busy
  defp do_busy_days([current | other_days], count) when current >= @busy_day,
    do: do_busy_days(other_days, count + 1)

  # Current day count insufficient to be busy
  defp do_busy_days([_ | other_days], count),
    do: do_busy_days(other_days, count)
end
