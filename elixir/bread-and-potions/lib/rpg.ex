defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(eated, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(%LoafOfBread{}, %Character{health: hp} = char) do
      {nil, Map.put(char, :health, hp + 5)}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{strength: recovered}, %Character{mana: mana} = char) do
      {%EmptyBottle{}, Map.put(char, :mana, mana + recovered)}
    end
  end

  defimpl Edible, for: Poison do
    def eat(%Poison{}, %Character{health: _ } = char) do
      {%EmptyBottle{}, Map.put(char, :health, 0)}
    end
  end
end
