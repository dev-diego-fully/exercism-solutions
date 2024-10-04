defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem)
  def push({}, elem), do: {elem}
  def push(list, elem), do: {elem, list}

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(list), do: do_count(list)

  defp do_count(list, count \\ 0)
  defp do_count({}, count), do: count
  defp do_count({_head}, count), do: count + 1
  defp do_count({_head, tail}, count), do: do_count(tail, count + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list)
  def empty?({}), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list)
  def peek({}), do: {:error, :empty_list}
  def peek({elem}), do: {:ok, elem}
  def peek({elem, _}), do: {:ok, elem}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list)
  def tail({}), do: {:error, :empty_list}
  def tail({_}), do: {:ok, {}}
  def tail({_, tl}), do: {:ok, tl}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list)
  def pop({}), do: {:error, :empty_list}
  def pop({head}), do: {:ok, head, {}}
  def pop({head, tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list),
    do: do_from_list(list)

  defp do_from_list(list, memo \\ {})

  defp do_from_list([], memo),
    do: memo |> reverse()

  defp do_from_list([head | tail], memo),
    do: tail |> do_from_list(memo |> push(head))

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list),
    do: do_to_list(list |> reverse())

  defp do_to_list(list, memo \\ [])

  defp do_to_list({}, memo),
    do: memo

  defp do_to_list({head}, memo),
    do: [head | memo]

  defp do_to_list({head, tail}, memo),
    do: tail |> do_to_list([head | memo])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(list)

  defp do_reverse(list, memo \\ {})

  defp do_reverse({}, memo),
    do: memo

  defp do_reverse({head}, memo),
    do: memo |> push(head)

  defp do_reverse({head, tail}, memo),
    do: tail |> do_reverse(memo |> push(head))
end
