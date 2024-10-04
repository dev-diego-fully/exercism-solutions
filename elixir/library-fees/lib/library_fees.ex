defmodule LibraryFees do

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!( string )
  end

  def before_noon?(datetime) do
    NaiveDateTime.beginning_of_day( datetime )
    |> NaiveDateTime.add( 12, :hour )
    |> (fn later, dt -> NaiveDateTime.before?( dt, later ) end).( datetime )
  end

  def return_date(checkout_datetime) do
    loan_duration = if before_noon?( checkout_datetime ) do 28 else 29 end
    checkout_datetime
    |> NaiveDateTime.add( loan_duration, :day )
    |> NaiveDateTime.to_date
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff( actual_return_datetime, planned_return_date  )
    |> max( 0 )
  end

  def monday?(datetime) do
    NaiveDateTime.to_date( datetime )
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string( checkout )
    return = datetime_from_string( return )
    days_late = return_date( checkout ) |> days_late( return )
    late_fee = (days_late * rate)
    if monday?( return ) do
      Integer.floor_div( late_fee, 2 )
    else
      late_fee
    end
  end
end
