defmodule PaintByNumber do
  @spec palette_bit_size(pos_integer()):: pos_integer()
  def palette_bit_size(color_count) do
    binary_base = 2
    first_pow_tried = 0
    loop = fn base, pow, checked, that_function ->
      if Integer.pow( base, pow ) >= checked do
        pow
      else
        that_function.( base, pow + 1, checked, that_function )
      end
    end
    loop.( binary_base, first_pow_tried, color_count, loop )
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    #test_bit_size 2
    <<0::size(2), 1::size(2), 2::size(2), 3::size(2)>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size( color_count )
    new_pixel = <<pixel_color_index::size(bit_size)>>
    <<new_pixel::bitstring, picture::bitstring>>
  end

  def get_first_pixel(<<>>, _) do
    nil
  end

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size( color_count )
    <<first_pixel::size(bit_size), _rest::bitstring>> = picture
    first_pixel
  end

  def drop_first_pixel(<<>>, _) do
    <<>>
  end

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size( color_count )
    <<_first_pixel::size(bit_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
