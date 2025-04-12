defmodule Rules do
  @doc """
  Returns whether or not pacman is able to eat a ghost given
  the given conditions.
  """
  @spec eat_ghost?(boolean, boolean) :: boolean
  def eat_ghost?(power_pellet_active?, touching_ghost?),
    do: power_pellet_active? and touching_ghost?

  @doc """
  Returns whether the player scores or not given the given conditions.
  """
  @spec score?(boolean, boolean) :: boolean
  def score?(touching_power_pellet?, touching_dot?),
    do: touching_power_pellet? or touching_dot?

  @doc """
  Returns whether the player loses the game given the given conditions.
  """
  @spec lose?(boolean, boolean) :: boolean
  def lose?(power_pellet_active?, touching_ghost?),
    do: not power_pellet_active? and touching_ghost?

  @doc """
  Returns whether or not the player wins the game given the
  conditions provided.
  """
  @spec win?(boolean, boolean, boolean) :: boolean
  def win?(has_eaten_all_dots?, power_pellet_active?, touching_ghost?),
    do:
      has_eaten_all_dots? and
        not lose?(power_pellet_active?, touching_ghost?)
end
