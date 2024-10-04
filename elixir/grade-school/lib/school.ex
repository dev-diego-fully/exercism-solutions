defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new(), do: %{}

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    if school |> Map.has_key?(name) do
      {:error, school}
    else
      {:ok, school |> Map.put(name, grade)}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    school
    |> Enum.to_list()
    |> Enum.filter(fn {_, sgrade} -> sgrade == grade end)
    |> Enum.map(&get_name/1)
    |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.to_list()
    |> Enum.sort(&student_compare/2)
    |> Enum.map(&get_name/1)
  end

  @spec student_compare(
          {String.t(), non_neg_integer()},
          {String.t(), non_neg_integer()}
        ) :: boolean()
  defp student_compare({name_a, grade_a}, {name_b, grade_b}),
    do: grade_a <= grade_b and name_a <= name_b

  @spec get_name({String.t(), non_neg_integer()}) :: String.t()
  defp get_name(student)
  defp get_name({name, _}), do: name
end
