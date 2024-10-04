defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data)

  def insert(%{data: current, left: nil, right: right}, data) when data <= current do
    %{data: current, left: new(data), right: right}
  end

  def insert(%{data: current, left: left, right: right}, data) when data <= current do
    %{data: current, left: insert(left, data), right: right}
  end

  def insert(%{data: current, left: left, right: nil}, data) when data > current do
    %{data: current, left: left, right: new(data)}
  end

  def insert(%{data: current, left: left, right: right}, data) when data > current do
    %{data: current, left: left, right: insert(right, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree)

  def in_order(nil), do: []

  def in_order(%{data: data, left: left, right: right}) do
    in_order(left)
    |> Enum.concat([data])
    |> Enum.concat(in_order(right))
  end
end
