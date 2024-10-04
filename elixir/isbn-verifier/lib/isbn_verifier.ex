defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn),
    do: isbn |> isbn_clean() |> cleaned_valid?()

  @spec cleaned_valid?(String.t()) :: boolean
  defp cleaned_valid?(isbn),
    do: has_valid_cleaned_format?(isbn) and has_valid_verification?(isbn)

  @spec isbn_clean(String.t()) :: String.t()
  defp isbn_clean(isbn),
    do: isbn |> String.replace(~r/-/, "")

  @spec has_valid_cleaned_format?(String.t()) :: boolean
  defp has_valid_cleaned_format?(isbn),
    do: isbn |> String.match?(~r/^\d{9}[\dX]$/)

  @spec has_valid_verification?(String.t()) :: boolean()
  defp has_valid_verification?(isbn) do
    isbn
    |> isbn_digits_value()
    |> isbn_check()
  end

  @spec isbn_check(non_neg_integer) :: non_neg_integer
  defp isbn_check(digits) do
    digits
    |> Enum.zip(10..1)
    |> Enum.map(fn {dig, mul} -> dig * mul end)
    |> Enum.sum()
    |> rem(11)
    |> (&==/2).(0)
  end

  @spec isbn_digits_value(String.t()) :: [non_neg_integer]
  defp isbn_digits_value(isbn) do
    isbn
    |> isbn_digits()
    |> Enum.map(&isbn_digit_value/1)
  end

  @spec isbn_digits(String.t()) :: [String.t()]
  defp isbn_digits(isbn) do
    ~r/[\dX]/
    |> Regex.scan(isbn)
    |> List.flatten()
  end

  @spec isbn_digit_value(Strint.t()) :: non_neg_integer()
  defp isbn_digit_value(digit)

  defp isbn_digit_value("X"),
    do: 10

  defp isbn_digit_value(digit),
    do: digit |> String.to_integer()
end
