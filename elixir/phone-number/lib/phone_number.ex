defmodule PhoneNumber do
  @phone_pattern ~r/^(\d)?((\d)\d{2}(\d)\d{6})$/
  @ignorable_pattern ~r/[\+\(\)\-\.\s]/

  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> remove_ignorables()
    |> validate()
  end

  @spec remove_ignorables(String.t()) :: String.t()
  defp remove_ignorables(number),
    do: number |> String.replace(@ignorable_pattern, "")

  @spec number_analyze(String.t()) :: [String.t()] | nil
  defp number_analyze(number),
    do: @phone_pattern |> Regex.run(number)

  @spec validate(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  defp validate(number) do
    case {number_analyze(number), String.length(number)} do
      {[_, c, _, _, _], _} when c not in ["", "1"] -> {:error, "11 digits must start with 1"}
      {[_, _, _, "0", _], _} -> {:error, "area code cannot start with zero"}
      {[_, _, _, "1", _], _} -> {:error, "area code cannot start with one"}
      {[_, _, _, _, "0"], _} -> {:error, "exchange code cannot start with zero"}
      {[_, _, _, _, "1"], _} -> {:error, "exchange code cannot start with one"}
      {[_, _, num, _, _], _} -> {:ok, num}
      {nil, digits} when digits < 10 -> {:error, "must not be fewer than 10 digits"}
      {nil, digits} when digits > 11 -> {:error, "must not be greater than 11 digits"}
      {nil, _} -> {:error, "must contain digits only"}
    end
  end
end
