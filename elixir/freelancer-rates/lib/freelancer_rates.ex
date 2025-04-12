defmodule FreelancerRates do
  @hours_worked_per_day 8.0
  @days_worked_per_month 22.0

  @doc """
  Calculates the freelancer rate given the hourly rate provided.
  """
  @spec daily_rate(float) :: float
  def daily_rate(hourly_rate),
    do: hourly_rate * @hours_worked_per_day

  @doc """
  Returns the new price after applying the discount rate.
  """
  @spec apply_discount(float, float) :: float
  def apply_discount(before_discount, discount) do
    discount
    |> remaining_rate()
    |> then(&(&1 * before_discount))
  end

  @doc """
  Returns the monthly rate given the daily rate and the provided
  discount rate.
  """
  @spec monthly_rate(float, float) :: float
  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_price(discount)
    |> then(&(&1 * @days_worked_per_month))
    |> ceil()
  end

  @doc """
  Returns the number of days covered by the provided budget given the daily
  rate and the discount rate.
  """
  @spec days_in_budget(float, float, float) :: float
  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate
    |> daily_price(discount)
    |> then(&(budget / &1))
    |> Float.floor(1)
  end

  # Returns the daily freelancer price given the daily rate
  # and the discount rate.
  @spec daily_price(float, float) :: float
  defp daily_price(hourly_rate, discount),
    do: hourly_rate |> daily_rate() |> apply_discount(discount)

  # Returns the remaining rate given the given percentage.
  @spec remaining_rate(float) :: float
  defp remaining_rate(rate),
    do: 1 - rate / 100
end
