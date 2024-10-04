defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(~r/\s/)
    |> Enum.map(&rule1/1)
    |> Enum.map(&rule3/1)
    |> Enum.map(&rule4/1)
    |> Enum.map(&rule2/1)
    |> Enum.map(fn {w, _} -> w end)
    |> Enum.join(" ")
  end

  @spec rule1(String.t()) :: {String.t(), boolean()}
  defp rule1(word) do
    if Regex.match?(~r/^([aeiou]|xr|yt)/, word) do
      {word <> "ay", true}
    else
      {word, false}
    end
  end

  @spec rule2({String.t(), boolean()}) :: {String.t(), boolean()}
  defp rule2({word, false}) do
    pattern = ~r/^([^aeiou]+)(.*)/

    case Regex.run(pattern, word) do
      nil -> {word, false}
      [_, prefix, rest] -> {rest <> prefix <> "ay", true}
    end
  end

  defp rule2(input), do: input

  defp rule3({word, false}) do
    pattern = ~r/^([^aeiou]*qu)(.*)/

    case Regex.run(pattern, word) do
      nil -> {word, false}
      [_, prefix, rest] -> {rest <> prefix <> "ay", true}
    end
  end

  defp rule3(input), do: input

  defp rule4({word, false}) do
    pattern = ~r/^([^aeiou]+)(y.*)/

    case Regex.run(pattern, word) do
      nil ->
        {word, false}

      [_, prefix, rest] ->
        {rest <> prefix <> "ay", true}
    end
  end

  defp rule4(input), do: input
end
