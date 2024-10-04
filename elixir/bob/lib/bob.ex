defmodule Bob do
  defp silence?(input) do
    not Regex.match?(~r/\S/, input)
  end

  defp screaming?(input) do
    Regex.match?(~r/\p{Lu}/, input) and not Regex.match?(~r/\p{Ll}/, input)
  end

  defp questioning?(input) do
    Regex.match?(~r/\?\s*$/, input)
  end

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      silence?(input) ->
        "Fine. Be that way!"

      screaming?(input) ->
        if questioning?(input) do
          "Calm down, I know what I'm doing!"
        else
          "Whoa, chill out!"
        end

      questioning?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end
end
