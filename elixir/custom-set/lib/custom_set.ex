defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}
  defstruct map: []

  @spec new(Enum.t()) :: t
  defp new(enumerable \\ [])

  defp new([]),
    do: %CustomSet{map: []}

  defp new(enumerable),
    do: enumerable |> Enum.reduce(new(), &add(&2, &1))

  @spec empty?(t) :: boolean
  def empty?(custom_set)

  def empty?(%CustomSet{map: []}),
    do: true

  def empty?(%CustomSet{map: [_a | _tail]}),
    do: false

  @spec contains?(t, any) :: boolean
  def contains?(%CustomSet{map: map}, element),
    do: element in map

  @spec subset?(t, t) :: boolean
  def subset?(%CustomSet{map: elms1}, other_set),
    do: elms1 |> Enum.all?(fn x -> CustomSet.contains?(other_set, x) end)

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    custom_set_1
    |> CustomSet.intersection(custom_set_2)
    |> CustomSet.empty?()
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2)

  def equal?(this, other) do
    this |> CustomSet.difference(other) |> CustomSet.empty?() and
    other |> CustomSet.difference(this) |> CustomSet.empty?()
  end

  @spec add(t, any) :: t
  def add(custom_set, element)

  def add(%CustomSet{map: []}, element),
    do: %CustomSet{map: [element]}

  def add(%CustomSet{map: map} = custom_set, element) do
    if Enum.any?(map, fn x -> x == element end) do
      custom_set
    else
      %CustomSet{map: [element | map]}
    end
  end

  @spec intersection(t, t) :: t
  def intersection(%CustomSet{map: elms1}, other_set) do
    elms1
    |> Enum.filter(fn x -> other_set |> CustomSet.contains?(x) end)
    |> CustomSet.new()
  end

  @spec difference(t, t) :: t
  def difference(%CustomSet{map: elms1}, other_set) do
    elms1
    |> Enum.reject(fn x -> other_set |> contains?(x) end)
    |> CustomSet.new()
  end

  @spec union(t, t) :: t
  def union(%CustomSet{map: elms1}, %CustomSet{map: elms2}),
    do: CustomSet.new(elms1 ++ elms2)
end
