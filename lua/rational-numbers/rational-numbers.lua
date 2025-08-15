--- Represents a rational number (a fraction) as a table containing its numerator and denominator.
--- @alias Rational {[1]: integer, [2]: integer}

local do_reduce

--- Reduces a rational number to its simplest form.
--- This function is the public-facing interface for the internal `do_reduce` function.
--- @param a Rational The rational number to be reduced.
--- @return Rational -- The rational number in its simplest form.
local function reduce(a)
  return do_reduce(a[1], a[2], 2)
end

--- Adds two rational numbers.
--- @param a Rational The first rational number.
--- @param b Rational The second rational number.
--- @return Rational -- The sum of the two rational numbers, reduced.
local function add(a, b)
  local c = {
    a[1] * b[2] + b[1] * a[2],
    a[2] * b[2]
  }
  return reduce(c)
end

--- Subtracts one rational number from another.
--- @param a Rational The rational number to subtract from.
--- @param b Rational The rational number to subtract.
--- @return Rational -- The difference of the two rational numbers, reduced.
local function subtract(a, b)
  local c = {
    a[1] * b[2] - b[1] * a[2],
    a[2] * b[2]
  }
  return reduce(c)
end

--- Multiplies two rational numbers.
--- @param a Rational The first rational number.
--- @param b Rational The second rational number.
--- @return Rational -- The product of the two rational numbers, reduced.
local function multiply(a, b)
  local c = {
    a[1] * b[1],
    a[2] * b[2]
  }
  return reduce(c)
end

--- Divides one rational number by another.
--- @param a Rational The rational number to be divided.
--- @param b Rational The rational number to divide by.
--- @return Rational -- The quotient of the two rational numbers, reduced.
local function divide(a, b)
  local c = {
    a[1] * b[2],
    b[1] * a[2]
  }
  return reduce(c)
end

--- Calculates the absolute value of a rational number.
--- @param a Rational The rational number.
--- @return Rational -- A new rational number representing the absolute value.
local function abs(a)
  local b = {
    math.abs(a[1]),
    math.abs(a[2])
  }
  return reduce(b)
end

--- Calculates the exponentiation of a rational number by an integer power.
--- @param a Rational The rational number base.
--- @param p number The integer exponent.
--- @return Rational -- A new rational number representing the result, reduced.
local function exp_rational(a, p)
  local m = math.abs(p)
  local c
  if p < 0 then
    c = { a[2] ^ m, a[1] ^ m }
  else
    c = { a[1] ^ m, a[2] ^ m }
  end
  return reduce(c)
end

--- Calculates the exponentiation of a real number by a rational number power.
--- @param p number The real number base.
--- @param a Rational The rational number exponent.
--- @return number -- The result of the exponentiation.
local function exp_real(p, a)
  return p ^ (a[1] / a[2])
end

--- A private, recursive helper function to reduce a fraction to its simplest form.
--- It finds the greatest common divisor by trial division and reduces the fraction.
--- @param a integer The numerator.
--- @param b integer The denominator.
--- @param div integer The current divisor to test.
--- @return Rational -- The reduced rational number.
function do_reduce(a, b, div)
  if a == 0 then
    return { 0, 1 }
  elseif b < 0 then
    return do_reduce(-a, -b, div)
  elseif math.abs(a) < div or math.abs(b) < div then
    return { a, b }
  elseif a % div == 0 and b % div == 0 then
    return do_reduce(a / div, b / div, div)
  elseif div % 2 == 1 then
    return do_reduce(a, b, div + 2)
  else
    return do_reduce(a, b, div + 1)
  end
end

return {
  add = add,
  subtract = subtract,
  multiply = multiply,
  divide = divide,
  abs = abs,
  exp_rational = exp_rational,
  exp_real = exp_real,
  reduce = reduce
}
