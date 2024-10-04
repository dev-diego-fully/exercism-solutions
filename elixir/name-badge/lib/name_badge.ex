defmodule NameBadge do
  def print(id, name, department) do
    if department do
      if id do
        "[#{id}] - #{name} - #{String.upcase( department )}"
      else
        "#{name} - #{String.upcase( department )}"
      end
    else
      print(id, name, "OWNER")
    end

  end
end
