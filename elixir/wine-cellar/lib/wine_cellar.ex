defmodule WineCellar do

  @type cellar :: {String.t(), integer, String.t()}

  @doc """
  Returns a keyword list containing an explanation of each type of
  wine color.
  """
  @spec explain_colors() :: Keyword.t(String.t())
  def explain_colors() do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  @doc """
  Filters the wines from the given cellar that have the color and
  optionally the year and country (by the opts keyword).
  """
  @spec filter(cellar, atom(), Keyword.t(String.t() | integer())) :: cellar()
  def filter(cellar, color, opts \\ []) do
    Keyword.get_values(cellar, color)
    |> filter_by_year(opts |> Keyword.get(:year))
    |> filter_by_country(opts |> Keyword.get(:country))
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)

  defp filter_by_year(wines, nil) do
    wines
  end

  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)

  defp filter_by_country(wines, nil) do
    wines
  end

  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
