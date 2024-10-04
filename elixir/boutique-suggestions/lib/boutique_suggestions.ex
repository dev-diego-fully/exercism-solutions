defmodule BoutiqueSuggestions do
  def get_combinations(
        tops,
        bottoms,
        opts \\ %{maximum_price: 100}
      ) do
    for %{} = top <- tops,
        %{} = bottom <- bottoms,
        top.base_color != bottom.base_color,
        top.price + bottom.price <= (opts[:maximum_price] || 100) do
      {top, bottom}
    end
  end
end
