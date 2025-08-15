--- Represents a complex number.
--- Instances of this class are created using the `Complex.new` function.
--- @class Complex
--- @field r number The real part of the complex number.
--- @field i number The imaginary part of the complex number.
--- @field abs fun(): Complex A bound method to calculate the absolute value (magnitude).
--- @field conj fun(): Complex A bound method to calculate the complex conjugate.
--- @field exp fun(): Complex A bound method to calculate the complex exponential.
local Complex <const> = {}
--- A helper table containing the static, unbound methods for the Complex class.
local static_complex <const> = {}

local bind, is_close

--- Creates a new Complex number instance.
--- The constructor automatically binds methods like `abs`, `conj`, and `exp` to the new instance.
--- It also sets up metatables for operator overloading.
--- @param r number The real part of the complex number.
--- @param i? number The imaginary part of the complex number (defaults to 0).
--- @return Complex -- The new Complex instance.
function Complex.new(r, i)
    local props = { r = tonumber(r), i = i or 0.0 }

    props.abs = bind(static_complex.absolute, props)
    props.conj = bind(static_complex.conjugate, props)
    props.exp = bind(static_complex.exponentiation, props)

    return setmetatable(
        {},
        {
            __index = props,
            __add = static_complex.addition,
            __sub = static_complex.subtraction,
            __mul = static_complex.multiplication,
            __div = static_complex.division,
            __eq = static_complex.equals,
            __tostring = static_complex.tostring
        }
    )
end

--- Calculates the absolute value (magnitude) of a complex number.
--- @param num Complex The complex number.
--- @return number -- The absolute value.
function static_complex.absolute(num)
    return math.sqrt(num.r ^ 2 + num.i ^ 2)
end

--- Calculates the complex conjugate of a complex number.
--- The conjugate is a new complex number with the imaginary part negated.
--- @param num Complex The complex number.
--- @return Complex -- The new complex number representing the conjugate.
function static_complex.conjugate(num)
    return Complex.new(num.r, -num.i)
end

--- Calculates the complex exponential ($e^z$) using Euler's formula.
--- The result is a new complex number.
--- @param num Complex The complex number.
--- @return Complex -- The result of the exponentiation.
function static_complex.exponentiation(num)
    local exp = math.exp(num.r)
    local real = exp * math.cos(num.i)
    local imag = exp * math.sin(num.i)

    return Complex.new(real, imag)
end

--- A function for comparing two complex numbers.
--- It is used by the `__eq` metamethod. The comparison uses a tolerance for floating-point numbers.
--- @param left Complex The left-hand side of the comparison.
--- @param right any The right-hand side of the comparison.
--- @return boolean -- True if the real and imaginary parts are approximately equal, false otherwise.
function static_complex.equals(left, right)
    if type(right) ~= "table" and type(right) ~= "userdata" then
        return false
    elseif type(right.r) ~= "number" or type(right.i) ~= "number" then
        return false
    else
        return is_close(left.r, right.r, 1e-12) or is_close(left.i, right.i, 1e-12)
    end
end

--- A function for adding two complex numbers.
--- It is used by the `__add` metamethod.
--- @param left Complex The left-hand side of the operation.
--- @param right Complex The right-hand side of the operation.
--- @return Complex -- A new complex number representing the sum.
function static_complex.addition(left, right)
    local real = left.r + right.r
    local imag = left.i + right.i

    return Complex.new(real, imag)
end

--- A function for subtracting two complex numbers.
--- It is used by the `__sub` metamethod.
--- @param left Complex The left-hand side of the operation.
--- @param right Complex The right-hand side of the operation.
--- @return Complex -- A new complex number representing the difference.
function static_complex.subtraction(left, right)
    local real = left.r - right.r
    local imag = left.i - right.i

    return Complex.new(real, imag)
end

--- A function for multiplying two complex numbers.
--- It is used by the `__mul` metamethod.
--- @param left Complex The left-hand side of the operation.
--- @param right Complex The right-hand side of the operation.
--- @return Complex -- A new complex number representing the product.
function static_complex.multiplication(left, right)
    local real = left.r * right.r - left.i * right.i
    local imag = left.i * right.r + left.r * right.i

    return Complex.new(real, imag)
end

--- A function for dividing two complex numbers.
--- It is used by the `__div` metamethod.
--- @param left Complex The left-hand side of the operation.
--- @param right Complex The right-hand side of the operation.
--- @return Complex -- A new complex number representing the quotient.
function static_complex.division(left, right)
    local divisor = right.r ^ 2 + right.i ^ 2
    local real_dividend = left.r * right.r + left.i * right.i
    local imag_dividend = left.i * right.r - left.r * right.i

    return Complex.new(real_dividend / divisor, imag_dividend / divisor)
end

--- A function for converting a complex number to a string.
--- It is used by the `__tostring` metamethod.
--- @param num Complex The complex number to format.
--- @return string -- A string representation of the complex number.
function static_complex.tostring(num)
    local format = "Complex {r = %f, i = %f}"
    return format:format(num.r, num.i)
end

--- Creates a closure to bind a function to a specific object.
--- This pattern allows static methods to be called as instance methods.
--- @param fn function The function to bind.
--- @param obj any The object to bind the function to.
--- @return function -- A new function that calls `fn` with `obj` as its first argument.
function bind(fn, obj)
    return function(...)
        return fn(obj, ...)
    end
end

--- Checks if two numbers are approximately equal within a specified tolerance.
--- This is useful for comparing floating-point numbers.
--- @param a number The first number.
--- @param b number The second number.
--- @param max_diff number The maximum allowed difference between the numbers.
--- @return boolean -- True if the numbers are approximately equal, false otherwise.
function is_close(a, b, max_diff)
    local diff = math.abs(a - b)
    return diff <= max_diff
end

return Complex.new