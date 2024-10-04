defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({r, _i}), do: r

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_r, i}), do: i

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul({r1, i1}, {r2, i2}), do: {r1 * r2 - i1 * i2, i1 * r2 + r1 * i2}
  def mul({r1, i1}, b), do: {b * r1, b * i1}
  def mul(a, {r2, i2}), do: {a * r2, a * i2}
  def mul(a, b), do: {a * b, 0}

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add({r1, i1}, {r2, i2}), do: {r1 + r2, i1 + i2}
  def add(a, {r2, i2}), do: {a + r2, i2}
  def add({r1, i1}, b), do: {r1 + b, i1}
  def add(a, b), do: {a + b, 0}

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub({r1, i1}, {r2, i2}), do: {r1 - r2, i1 - i2}
  def sub(a, {r2, i2}), do: {a - r2, -i2}
  def sub({r1, i1}, b), do: {r1 - b, i1}
  def sub(a, b), do: {a - b, 0}

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div({r1, i1}, {r2, i2}) do
    d = r2 ** 2 + i2 ** 2
    {(r1 * r2 + i1 * i2) / d, (i1 * r2 - r1 * i2) / d}
  end

  def div({r1, i1}, b), do: {r1 / b, i1 / b}
  def div(a, {r2, i2}), do: ComplexNumbers.div({a, 0}, {r2, i2})

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({r, i}), do: :math.sqrt(r ** 2 + i ** 2)

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({r, i}), do: {r, -i}

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({r1, i1}) do
    {:math.cos(i1), :math.sin(i1)}
    |> ComplexNumbers.mul(:math.exp(r1))
  end
end
