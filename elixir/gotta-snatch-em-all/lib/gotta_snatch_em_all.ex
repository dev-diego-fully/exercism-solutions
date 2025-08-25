defmodule GottaSnatchEmAll do
  @moduledoc """
  A module for managing and analyzing card collections.

  This module provides a set of functions to handle common operations on card collections,
  such as adding, trading, counting, and comparing collections. The core data structure
  for a collection is a `MapSet`, which provides efficient set operations.

  The module defines two key types:
  - `card`: A string representing a single card.
  - `collection`: A `MapSet` of cards.
  """
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @doc """
  Creates a new card collection containing a single card.
  """
  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @doc """
  Adds a new card to a collection.

  Returns a tuple `{boolean, collection}`. The boolean indicates whether the card was already
  a member of the collection (`true` if it was, `false` otherwise).
  """
  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {collection |> MapSet.member?(card), collection |> MapSet.put(card)}
  end

  @doc """
  Trades a card from your collection for a new card.

  The `your_card` is removed and `their_card` is added to the collection.
  Returns a tuple `{boolean, collection}`. The boolean indicates if the trade was
  valid: `true` if `your_card` was in the collection and `their_card` was not,
  and `false` otherwise.
  """
  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    has_your_card = collection |> MapSet.member?(your_card)
    dont_has_their_card = not (collection |> MapSet.member?(their_card))

    {
      has_your_card and dont_has_their_card,
      collection |> MapSet.put(their_card) |> MapSet.delete(your_card)
    }
  end

  @doc """
  Removes duplicate cards from a list.

  The function converts the list to a `MapSet` to get a unique set of cards and then
  converts it back to a list. The order of elements in the returned list is not guaranteed.
  """
  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards
    |> MapSet.new()
    |> MapSet.to_list()
  end

  @doc """
  Counts the number of cards in `your_collection` that are not present in `their_collection`.
  """
  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    your_collection
    |> MapSet.difference(their_collection)
    |> MapSet.size()
  end

  @doc """
  Finds the cards that are common to all collections in a list.

  If the input list of collections is empty, it returns an empty list.
  Otherwise, it finds the intersection of all collections and returns a sorted list of the common cards.
  """
  @spec boring_cards([collection()]) :: [card()]
  def boring_cards(collections) do
    if collections |> Enum.empty?() do
      []
    else
      collections
      |> Enum.reduce(&MapSet.intersection/2)
      |> MapSet.to_list()
      |> Enum.sort()
    end
  end

  @doc """
  Calculates the total number of unique cards across all collections in a list.

  It merges all collections into a single union and then counts the total number of unique cards.
  """
  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) do
    collections
    |> Enum.reduce(MapSet.new(), &MapSet.union/2)
    |> Enum.count()
  end

  @doc """
  Splits a collection into two lists: one for "shiny" cards and one for all others.

  A card is considered "shiny" if its name starts with "Shiny".
  """
  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    collection
    |> MapSet.split_with(&shiny?/1)
    |> then(fn {a, b} -> {a |> MapSet.to_list(), b |> MapSet.to_list()} end)
  end

  # Checks if a card is "shiny".
  #
  # A card is considered "shiny" if its name begins with the string "Shiny".
  @spec shiny?(card()) :: boolean()
  defp shiny?(card),
    do: card |> String.starts_with?("Shiny")
end
