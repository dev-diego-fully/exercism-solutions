defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    date = Date.new!(year, month, day)
    time = Time.new!(hours, minutes, seconds)

    DateTime.new!(date, time)
    |> DateTime.add(1_000_000_000)
    |> convert()
  end

  defp convert(%DateTime{
         year: year,
         month: month,
         day: day,
         hour: hours,
         minute: minutes,
         second: seconds
       }) do
    {{year, month, day}, {hours, minutes, seconds}}
  end
end
