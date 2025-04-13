defmodule HighSchoolSweetheart do
  @name_separator " "
  @initials_separator " "
  @initial_separator "."

  @doc """
  Returns the first letter of the given name.
  """
  @spec first_letter(String.t()) :: String.grapheme()
  def first_letter(name) do
    name
    |> String.trim()
    |> String.at(0)
  end

  @doc """
  Returns the initial of the given name.
  (First letter + .)
  """
  @spec initial(String.t()) :: String.t()
  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> (&"#{&1}#{@initial_separator}").()
  end

  @doc """
  Returns the initials of a given full name.
  (Initials of each first or last name separately)
  """
  @spec initials(String.t()) :: String.t()
  def initials(full_name) do
    full_name
    |> String.split(@name_separator)
    |> Stream.map(&initial/1)
    |> Enum.join(@initials_separator)
  end

  @doc """
  Returns the ascii box containing the initials of the two given full names.
  """
  @spec pair(String.t(), String.t()) :: String.t()
  def pair(full_name1, full_name2) do
    [full_name1, full_name2]
    |> Enum.map(&initials/1)
    |> pair_from_initial()
  end

  # Returns the ascii box from a list containing two initial names
  @spec pair_from_initial([String.t()]) :: String.t()
  defp pair_from_initial([i1, i2]) do
    """
    ❤-------------------❤
    |  #{i1}  +  #{i2}  |
    ❤-------------------❤
    """
  end
end
