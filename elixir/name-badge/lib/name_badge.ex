defmodule NameBadge do

  @owner "OWNER"

  @doc """
  Prints an appropriate name badge given the employee's id, name and department.
  "[id] - name - DEPARTMENT"
  If there is no id, a badge with no id is printed.
  "name - DEPARTMENT"
  If there is no department, it is assumed to be the badge for the owner.
  """
  @spec print(String.t() | nil, String.t(), String.t() | nil) :: String.t()
  def print(id, name, department)

  def print(id, name, nil),
    do: print(id, name, @owner)

  def print(id, name, department) do
    if id do
      print_with_id(id, name, department)
    else
      print_without_id(name, department)
    end
  end

  # Prints the default badge when the id is present.
  @spec print_with_id(integer, String.t(), String.t()) :: String.t()
  defp print_with_id(id, name, department),
    do: "[#{id}] - #{name} - #{String.upcase(department)}"

  # Print badge when id is missing
  @spec print_without_id(String.t(), String.t()) :: String.t()
  defp print_without_id(name, department),
    do: "#{name} - #{String.upcase(department)}"
end
