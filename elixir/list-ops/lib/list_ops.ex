defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l),
    do: foldl(l, 0, fn _, acc -> acc + 1 end)

  @spec reverse(list) :: list
  def reverse(l),
    do: foldl(l, [], &[&1 | &2])

  @spec map(list, (any -> any)) :: list
  def map(l, f),
    do: foldl(l, [], fn e, acc -> [f.(e) | acc] end) |> reverse()

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l
    |> foldl(
      [],
      fn elem, acc ->
        if f.(elem) do
          [elem | acc]
        else
          acc
        end
      end
    )
    |> reverse()
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f)

  def foldl([], acc, _),
    do: acc

  def foldl([head | tail], acc, f),
    do: foldl(tail, head |> f.(acc), f)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f),
    do: l |> reverse() |> foldl(acc, f)

  @spec append(list, list) :: list
  def append(a, b),
    do: foldr(a, b, &[&1 | &2])

  @spec concat([[any]]) :: [any]
  def concat(ll),
    do: foldr(ll, [], &append/2)
end
