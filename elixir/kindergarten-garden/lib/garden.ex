defmodule Garden do
  @type plant :: :grass | :clover | :radishes | :violets

  @default_students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @spec info(String.t(), list) :: map
  def info(
        info_string,
        student_names \\ @default_students
      ) do
    plants = parse_plants(info_string)

    student_names
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.map(fn {name, index} -> {name, plants_for_student(plants, index)} end)
    |> Map.new()
  end

  @spec parse_plants(String.t()) :: [[plant()]]
  defp parse_plants(plants_string) do
    plants_string
    |> String.split("\n")
    |> Enum.slice(0, 2)
    |> Enum.map(&line_plants/1)
  end

  @spec plants_for_student([String.t()], non_neg_integer()) :: [plant()]
  defp plants_for_student(plants, student_index) do
    student_index
    |> indexes_for_student()
    |> Enum.map(fn {x, y} -> plants |> matrix_get(x, y) end)
    |> Enum.reject(&is_nil/1)
    |> List.to_tuple()
  end

  @spec line_plants(String.t()) :: [plant()]
  defp line_plants(line) do
    line
    |> String.to_charlist()
    |> Enum.map(&plant_from/1)
  end

  @spec plant_from(non_neg_integer()) :: plant()
  defp plant_from(char)
  defp plant_from(?G), do: :grass
  defp plant_from(?C), do: :clover
  defp plant_from(?R), do: :radishes
  defp plant_from(?V), do: :violets

  @spec indexes_for_student(non_neg_integer) :: list({non_neg_integer(), non_neg_integer()})
  defp indexes_for_student(student_index) do
    [
      {0, student_index * 2},
      {0, student_index * 2 + 1},
      {1, student_index * 2},
      {1, student_index * 2 + 1}
    ]
  end

  @spec matrix_get(list(list(any())), non_neg_integer(), non_neg_integer()) :: any()
  defp matrix_get(matrix, x, y),
    do: matrix |> Enum.at(x) |> Enum.at(y)
end
