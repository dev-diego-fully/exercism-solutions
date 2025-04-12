defmodule AllYourBase do
  defmodule DigitsOps do
    @moduledoc false

    @smallest_digit 0

    # Returns a closure that checks whether the given digit is
    # valid for the base in which it was constructed.
    @spec base_checker(integer) :: (integer -> boolean)
    def base_checker(base) do
      fn digit ->
        digit >= @smallest_digit and digit < base
      end
    end

    # Returns a closure that returns the value of a given digit at the
    # given position based on the base used to construct the closure.
    @spec value_getter(integer) :: ({integer, integer} -> integer)
    def value_getter(base) do
      fn {digit, position} ->
        digit * Integer.pow(base, position)
      end
    end
  end

  defmodule PositionalUtils do
    @moduledoc false

    @min_digits 1
    @min_defined_log 1

    # Calculates and returns the number of digits required to represent
    # the given value in the given base.
    @spec digits_count(integer, integer) :: integer
    def digits_count(value, base)

    # special logs value
    def digits_count(value, _) when value <= @min_defined_log,
      do: @min_digits

    # common case
    def digits_count(value, base) do
      log_in_base = :math.log(value) / :math.log(base)

      log_in_base
      |> Float.ceil()
      |> trunc()
    end

    # Checks and returns whether the digits are valid with a number in the given base.
    @spec valid_number?([integer], integer) :: boolean
    def valid_number?(digits, base),
      do: Enum.all?(digits, AllYourBase.DigitsOps.base_checker(base))
  end

  @smallest_base 2

  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base)

  # invalid input base
  def convert(_, input_base, _) when input_base < @smallest_base,
    do: {:error, "input base must be >= 2"}

  # invalid output base
  def convert(_, _, output_base) when output_base < @smallest_base,
    do: {:error, "output base must be >= 2"}

  # without digits is treated as zero in all bases
  def convert([], _, _),
    do: {:ok, [0]}

  # attempt to convert to the same base
  def convert(digits, same_base, same_base) do
    if PositionalUtils.valid_number?(digits, same_base) do
      {:ok, digits}
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  # commom case
  def convert(digits, input_base, output_base) do
    if !PositionalUtils.valid_number?(digits, input_base) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      {
        :ok,
        digits
        |> digits_to_value(input_base)
        |> value_to_digits(output_base)
      }
    end
  end

  # Obtains the real value of the positional representation
  # given by the digits and the base.
  @spec digits_to_value([integer], integer) :: integer
  defp digits_to_value(digits, base) do
    digits
    |> Enum.reverse()
    |> Stream.with_index()
    |> Stream.map(DigitsOps.value_getter(base))
    |> Enum.reduce(&+/2)
  end

  # Converts the given value to its positional representation
  # in the given base.
  @spec value_to_digits(integer, integer) :: [integer]
  defp value_to_digits(value, base) do
    (PositionalUtils.digits_count(value, base) - 1)..0//-1
    |> Stream.map(fn pow -> Integer.pow(base, pow) end)
    |> Stream.map(fn base_pows -> Integer.floor_div(value, base_pows) end)
    |> Enum.map(fn val -> rem(val, base) end)
  end
end
