defmodule RPG.CharacterSheet do

  # Contains each of the messages that will be displayed by this module.
  @messages %{
    welcome: "Welcome! Let's fill out your character sheet together.",
    name_ask: "What is your character's name?\n",
    class_ask: "What is your character's class?\n",
    level_ask: "What is your character's level?\n"
  }

  @doc """
  Displays a welcome message to the user.
  """
  @spec welcome() :: nil
  def welcome() do
    @messages[:welcome]
    |> IO.puts()
  end

  @doc """
  Asks the user for their character's name and then returns their answer.
  """
  @spec ask_name() :: :eof | {:error, term()} | String.t()
  def ask_name() do
    @messages[:name_ask]
    |> ask()
    |> process_awnser()

  end

  @doc """
  Asks the user what class their character is and then returns their answer.
  """
  @spec ask_class() :: :eof | {:error, term()} | String.t()
  def ask_class() do
    @messages[:class_ask]
    |> ask()
    |> process_awnser()
  end

  @doc """
  Asks the user what level their character is at and then returns
  their answer as an integer.
  """
  @spec ask_level() :: :eof | {:error, term()} | String.t()
  def ask_level() do
    @messages[:level_ask]
    |> ask()
    |> process_awnser(&String.to_integer/1)
  end

  @doc """
  Asks the user for each piece of data about their character (name, class and level)
  and thenreturns a character with that data.
  """
  @spec run() :: %{name: String.t(), class: String.t(), level: integer}
  def run() do
    welcome()
    [{:name, ask_name()}, {:class, ask_class()}, {:level, ask_level()}]
    |> Enum.into(%{})
    |> IO.inspect(label: "Your character")
  end

  # Displays the given message to the user and returns what the user
  # responds to that message.
  @spec ask(String.t()) :: String.t() | {:error, term()}
  defp ask(question) do
    case question |> IO.gets() do
      :eof -> {:no_awnser, :eof}
      {:error, _} = error -> {:no_awnser, error}
      data -> data |> String.trim()
    end
  end

  # Receives a response from the user and if it is valid, applies an
  # operation to it (if there is an operation to be performed) and
  # returns the result.
  # Otherwise, it returns the reason for the failure.
  defp process_awnser(awnser, pos_op \\ nil)

  # Invalid answer
  defp process_awnser({:no_awser, reason}, _),
    do: reason

  # No operation to perform
  defp process_awnser(awnser, nil),
    do: awnser

  # Main case: Valid response and operation executed.
  defp process_awnser(awnser, op),
    do: awnser |> op.()

end
