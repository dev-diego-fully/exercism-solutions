defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path_keys = String.split( path, "." )
    deep = fn that, data, current_key, others_keys ->
      if others_keys != [] do
        that.( that, data[current_key], hd(others_keys), tl(others_keys) )
      else
        data[ current_key ]
      end
    end
    deep.( deep, data, hd(path_keys), tl(path_keys) )
  end

  def get_in_path(data, path) do
    get_in( data, String.split( path, "." ) )
  end
end
