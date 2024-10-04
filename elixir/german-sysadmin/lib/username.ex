defmodule Username do
  def sanitize(username) do
    List.foldr(
      username, ~c"",
      fn elem, acc ->
        case elem do
          ?ä -> ~c"ae" ++ acc
          ?ö -> ~c"oe" ++ acc
          ?ü -> ~c"ue" ++ acc
          ?ß -> ~c"ss" ++ acc
          ?_ -> ~c"_"  ++ acc
          elem when elem in ?a..?z -> [ elem | acc ]
          _ -> acc
        end
      end
    )
  end
end
