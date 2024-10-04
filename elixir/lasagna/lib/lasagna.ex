defmodule Lasagna do
  def expected_minutes_in_oven(), do: 40

  def remaining_minutes_in_oven( passed_minutes ),
    do: Kernel.max( expected_minutes_in_oven() - passed_minutes, 0)

  def preparation_time_in_minutes( layers_number ),
    do: 2 * layers_number

  def total_time_in_minutes( layers_number, cooking_time ),
    do: preparation_time_in_minutes( layers_number ) + cooking_time

  def alarm(), do: "Ding!"
end
