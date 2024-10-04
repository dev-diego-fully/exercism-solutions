defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts( "Welcome! Let's fill out your character sheet together.")
  end

  def ask_name() do
    case IO.gets( "What is your character's name?\n" ) do
      :eof -> :eof
      { :error, reason } -> { :error, reason }
      data -> String.trim( data )
    end
  end

  def ask_class() do
    case IO.gets( "What is your character's class?\n" ) do
      :eof -> :eof
      { :error, reason } -> { :error, reason }
      data -> String.trim( data )
    end
  end

  def ask_level() do
    case IO.gets( "What is your character's level?\n" ) do
      :eof -> :eof
      { :error, reason } -> { :error, reason }
      data -> String.trim( data ) |> String.to_integer( )
    end
  end

  def run() do
    welcome()
    sheet = %{
      name: ask_name(),
      class: ask_class(),
      level: ask_level()
    }
    IO.inspect( sheet, label: "Your character" )
  end
end
