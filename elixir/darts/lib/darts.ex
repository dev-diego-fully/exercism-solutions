defmodule Darts do
  @type position :: {number, number}

  defp distance_between( {ax, ay}, {bx, by} ) do
    dx = ax - bx
    dy = ay - by
    Float.pow( Float.pow( dx, 2 ) + Float.pow( dy, 2 ), 1/2 )
  end

  defp distance_from_center( position ) do
    distance_between( position, { 0.0, 0.0 } )
  end

  defp in_circle?( position, radius ) do
    not( distance_from_center( position ) > radius )
  end

  defp scores?( checked_score, position ) do
    cond do
      checked_score == 10 -> in_circle?( position, 1 )
      checked_score == 5 -> in_circle?( position, 5 )
      checked_score == 1 -> in_circle?( position, 10 )
      checked_score == 0 -> true
    end
  end

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    cond do
      scores?( 10, { x, y } ) -> 10
      scores?( 5,  { x, y } ) -> 5
      scores?( 1,  { x, y } ) -> 1
      scores?( 0,  { x, y } ) -> 0
    end
  end
end
