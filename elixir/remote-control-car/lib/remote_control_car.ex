defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{
      nickname: nickname
    }
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}),
    do: "#{distance} meters"

  def display_battery(%RemoteControlCar{battery_percentage: 0}),
    do: "Battery empty"

  def display_battery(%RemoteControlCar{battery_percentage: battery_level}),
    do: "Battery at #{battery_level}%"

  def drive(%RemoteControlCar{battery_percentage: 0} = car), do: car

  def drive(
        %RemoteControlCar{
          battery_percentage: battery_level,
          distance_driven_in_meters: distance
        } = car
      )
      when battery_level > 0 do
    %{car | distance_driven_in_meters: distance + 20, battery_percentage: battery_level - 1}
  end
end
