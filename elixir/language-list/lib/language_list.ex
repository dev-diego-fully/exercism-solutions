defmodule LanguageList do
  @functional_language "Elixir"

  @doc """
  Returns an empty list
  """
  @spec new() :: [String.t()]
  def new(),
    do: []

  @doc """
  Adds the given language to the beginning of the given list
  """
  @spec add([String.t()], String.t()) :: [String.t()]
  def add(list, language),
    do: [language | list]

  @doc """
  Removes the first element from the given list
  """
  @spec remove([String.t()]) :: [String.t()]
  def remove([_ | tail]),
    do: tail

  @doc """
  Returns the first element of the list
  """
  @spec first([String.t()]) :: [String.t()]
  def first([head | _]),
    do: head

  @doc """
  Returns the total number of elements in the given list
  """
  @spec count([String.t()]) :: integer()
  def count(list),
    do: list |> length()

  @doc """
  Returns whether the given list has a functional language or not.
  (Checks if there is Elixir in the list)
  """
  @spec functional_list?([String.t()]) :: [String.t()]
  def functional_list?(list),
    do: @functional_language in list
end
