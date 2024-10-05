local cars = {}
local percent = 0.01
local minutes_in_hours = 60
local price_per_car = 10000
local price_for_ten_group = 95000

-- returns the amount of working cars produced by the assembly line every hour
function cars.calculate_working_cars_per_hour(production_rate, success_rate)
  return production_rate * success_rate * percent
end

-- returns the amount of working cars produced by the assembly line every minute
function cars.calculate_working_cars_per_minute(production_rate, success_rate)
  local per_hour = cars.calculate_working_cars_per_hour(
    production_rate, success_rate
  )
  return per_hour // minutes_in_hours
end

-- returns the cost of producing the given number of cars
function cars.calculate_cost(cars_count)
  local ten_groups = cars_count // 10
  local individuals_cars = cars_count % 10
  local groupeds_price = ten_groups * price_for_ten_group
  local individuals_price = individuals_cars * price_per_car

  return math.floor(groupeds_price + individuals_price)
end

return cars
