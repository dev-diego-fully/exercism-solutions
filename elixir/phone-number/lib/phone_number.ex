defmodule PhoneNumber do
  @phone_pattern ~r/^(\d)?((\d)\d{2}(\d)\d{6})$/
  @ignorable_pattern ~r/[\+\(\)\-\.\s]/

  @typep number_analysis ::
           %{
             country: String.t(),
             area_start: String.t(),
             exchange_start: String.t(),
             number: String.t()
           }
           | %{digits: non_neg_integer()}

  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> remove_ignorables()
    |> analyze_number()
    |> validate()
  end

  @spec remove_ignorables(String.t()) :: String.t()
  defp remove_ignorables(number),
    do: number |> String.replace(@ignorable_pattern, "")

  @spec analyze_number(String.t()) :: number_analysis
  defp analyze_number(number) do
    case @phone_pattern |> Regex.run(number) do
      [_, country, num, area_start, exchange_start] ->
        %{
          country: country,
          area_start: area_start,
          exchange_start: exchange_start,
          number: num
        }

      nil ->
        %{digits: String.length(number)}
    end
  end

  @spec validate(number_analysis) :: {:ok, String.t()} | {:error, String.t()}
  defp validate(analyzed)

  defp validate(%{country: country}) when country not in ["", "1"],
    do: {:error, "11 digits must start with 1"}

  defp validate(%{area_start: "0"}),
    do: {:error, "area code cannot start with zero"}

  defp validate(%{area_start: "1"}),
    do: {:error, "area code cannot start with one"}

  defp validate(%{exchange_start: "0"}),
    do: {:error, "exchange code cannot start with zero"}

  defp validate(%{exchange_start: "1"}),
    do: {:error, "exchange code cannot start with one"}

  defp validate(%{digits: digits}) when digits < 10,
    do: {:error, "must not be fewer than 10 digits"}

  defp validate(%{digits: digits}) when digits > 11,
    do: {:error, "must not be greater than 11 digits"}

  defp validate(%{number: number}),
    do: {:ok, number}

  defp validate(_),
    do: {:error, "must contain digits only"}
end
