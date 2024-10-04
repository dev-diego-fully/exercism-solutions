defmodule FreelancerRates do

  def daily_rate( hourly_rate ) do
    day_duration_hours = 8.0
    hourly_rate * day_duration_hours
  end

  def apply_discount( before_discount, discount ) do
    remaining_rate = 1 - discount / 100
    before_discount * remaining_rate
  end

  def monthly_rate( hourly_rate, discount ) do
    month_duration_days = 22.0
    daily_price = apply_discount( daily_rate( hourly_rate ), discount )
    monthly_price = daily_price * month_duration_days
    ceil(
      monthly_price
    )
  end

  def days_in_budget( budget, hourly_rate, discount ) do
    daily_price = apply_discount( daily_rate( hourly_rate ), discount )
    Float.floor( budget/daily_price, 1 )
  end
end
