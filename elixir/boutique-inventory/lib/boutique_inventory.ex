defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    get_price = fn i -> i[:price] end
    Enum.sort_by(inventory, get_price)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn item -> item[:price] == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(
      inventory,
      fn item ->
        name = String.replace(item[:name], old_word, new_word)
        Map.replace(item, :name, name)
      end
    )
  end

  def increase_quantity(item, count) do
    key = :quantity_by_size

    quantities =
      Map.get(item, key)
      |> Enum.into(%{}, fn {k, q} -> {k, count + q} end)

    Map.replace(item, key, quantities)
  end

  def total_quantity(item) do
    Enum.reduce(item[:quantity_by_size], 0, fn {_, x}, acc -> x + acc end)
  end
end
