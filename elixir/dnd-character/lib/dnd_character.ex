defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    floor(score / 2) - 5
  end

  @spec ability :: pos_integer()
  def ability do
    1..4
    |> Enum.map(fn _ -> Enum.random(1..6) end)
    |> Enum.sort()
    |> Enum.slice(1, 3)
    |> Enum.reduce(&+/2)
  end

  @spec character :: t()
  def character do
    constituiton = ability()

    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: constituiton,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: 10 + modifier(constituiton)
    }
  end
end
