defmodule BirdCount do

  def today(list)
  when length( list ) > 0 do
    hd( list )
  end

  def today(_list) do
    nil
  end

  def increment_day_count(list)
  when length( list ) > 0 do
    [ hd( list ) + 1 | tl( list ) ]
  end

  def increment_day_count(_list) do
    [ 1 ]
  end

  def has_day_without_birds?(list)
  when length( list ) == 0 do
    false
  end

  def has_day_without_birds?(list)
  when hd( list ) == 0 do
    true
  end

  def has_day_without_birds?(list) do
    has_day_without_birds?( tl( list ) )
  end

  def total(list)
  when length(list) > 0 do
    hd( list ) + total( tl( list ) )
  end

  def total(_list) do
    0
  end

  def busy_days(list)
  when length( list ) > 0 do
    cond do
      hd( list ) >= 5 -> 1 + busy_days( tl( list ) )
      true -> busy_days( tl( list ) )
    end
  end

  def busy_days(_list) do
    0
  end

end
