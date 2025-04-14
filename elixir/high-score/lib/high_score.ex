defmodule HighScore do

  @default_score 0

  @type scores :: %{String.t() => integer()}

  @doc """
  Returns a new, empty high scores register.
  """
  @spec new() :: scores()
  def new(),
    do: %{}

  @doc """
  Adds the given player to the given map. If a score is given,
  the player is added with that score, otherwise he is added
  with the default score (0).
  """
  @spec add_player(scores(), String.t(), integer()) :: scores()
  def add_player(scores, name, score \\ @default_score)

  def add_player(scores, name, score),
    do: scores |> Map.put(name, score)

  @doc """
  Removes the given player from the given high score record.
  The player's score is also deleted.
  """
  @spec remove_player(scores(), String.t()) :: scores()
  def remove_player(scores, name),
    do: scores |> Map.delete(name)

  @doc """
  Sets the given player's score in the given record to the
  default score (0)
  """
  @spec reset_score(scores(), String.t()) :: scores()
  def reset_score(scores, name),
    do: scores |> Map.put(name, @default_score)

  @doc """
  Updates the score of the given player in the given record.
  Given a score value, adds that value to the current score
  of the given player.
  """
  @spec update_score(scores(), String.t(), integer()) :: scores()
  def update_score(scores, name, score),
    do: scores |> Map.update(name, score, &(&1 + score))

  @doc """
  Returns the name of all players present in the given high
  score record.
  """
  @spec get_players(scores()) :: [String.t()]
  def get_players(scores),
    do: scores |> Map.keys()
end
