defmodule KitchenCalculator do
  def get_volume( { _unit, value } = _volume_pair ) do
    value
  end

  def to_milliliter( { :milliliter, _ } = volume_pair ) do
    volume_pair
  end

  def to_milliliter( { :cup, value } = _volume_pair ) do
    { :milliliter, value * 240 }
  end

  def to_milliliter( { :fluid_ounce, value } = _volume_pair ) do
    { :milliliter, value * 30 }
  end

  def to_milliliter( { :teaspoon, value } = _volume_pair ) do
    { :milliliter, value * 5 }
  end

  def to_milliliter( { :tablespoon, value } = _volume_pair ) do
    { :milliliter, value * 15 }
  end

  def from_milliliter( { :milliliter, _ } = volume_pair, _ = :milliliter ) do
    volume_pair
  end

  def from_milliliter( { :milliliter, value } = _volume_pair, unit = :cup ) do
    { unit, value / 240 }
  end

  def from_milliliter( { :milliliter, value } = _volume_pair, unit = :fluid_ounce ) do
    { unit, value / 30 }
  end

  def from_milliliter( { :milliliter, value } = _volume_pair, unit = :teaspoon ) do
    { unit, value / 5 }
  end

  def from_milliliter( { :milliliter, value } = _volume_pair, unit = :tablespoon ) do
    { unit, value / 15 }
  end

  def convert( volume_pair, unit ) do
    from_milliliter( to_milliliter( volume_pair ), unit )
  end
end
