defmodule Clock do
  defstruct hour: 0, minute: 0
  
  defmodule Minutes do
    @minutes_in_hour 60
    @hours_in_day 24
    @minutes_in_day @hours_in_day * @minutes_in_hour
    
    # Transforms the pair of hours and minutes into an integer
    # with only possible minutes within a day.
    @spec from_pair(integer, integer) :: integer
    def from_pair(hour, minute) do
      (hour * @minutes_in_hour + minute)
      |> from()
    end
    
    # Gets the number of hours in minutes.
    @spec get_hour(integer) :: integer
    def get_hour(minutes) do
      minutes
      |> Integer.floor_div(@minutes_in_hour)
    end
    
    # Gets the amount of minutes left when minutes is converted
    # to hours.
    @spec get_minute(integer) :: integer
    def get_minute(minutes) do
      minutes
      |> rem(@minutes_in_hour)
    end
    
    # Gets the amount of minutes by wrapping the passed integer
    # into the amount of minutes per day.
    @spec from(integer) :: integer
    defp from(minutes)
    
    # When the value is outside the range, it is either positive
    # or negative.
    defp from(minutes) when abs(minutes) >= @minutes_in_day do
      minutes
      |> rem(@minutes_in_day)
      |> from()
    end
    
    # When the value is negative, but within the range of minutes
    # in the day.
    defp from(minutes) when minutes < 0 do
      (@minutes_in_day + minutes)
      |> from()
    end
    
    # The value is already fully usable.
    defp from(minutes),
      do: minutes
  end

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    Minutes.from_pair(hour, minute)
    |> from_minutes()
  end
  
  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    Minutes.from_pair(hour, minute + add_minute)
    |> from_minutes()
  end

  # Get the clock from an integer value that represents the total
  # number of minutes in a given hour (Ex. 100 => 1:40)
  @spec from_minutes(integer) :: Clock
  defp from_minutes(minutes) do
    %Clock{
      hour: minutes |> Minutes.get_hour(),
      minute: minutes |> Minutes.get_minute()
    }
  end
end

defimpl String.Chars, for: Clock do

  @clock_slot_digits 2
  
  def to_string(%Clock{hour: hour, minute: minute}),
    do: "#{get_formated(hour)}:#{get_formated(minute)}"

  # Transforms the integer value into a string already formatted to fit
  # into a clock value "slot" (hour or minute)
  defp get_formated(value) do
    value
    |> Integer.to_string()
    |> String.pad_leading(@clock_slot_digits, "0")
  end
end
