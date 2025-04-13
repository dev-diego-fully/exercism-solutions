defmodule GuessingGame do
  @messages %{
    no_guess: "Make a guess",
    correct_guess: "Correct",
    close_guess: "So close",
    high_guess: "Too high",
    low_guess: "Too low"
  }

  @close_range 1

  defguardp is_close(x, y) when (x - y) |> abs() <= @close_range

  @doc """
  Compares the player's guess with the chosen secret number and returns
  a message accordingly. This message helps guide the player in their
  next guess.
  """
  @spec compare(number(), number() | :no_guess) :: String.t()
  def compare(secret_number, guess \\ :no_guess)

  # No guess made
  def compare(_, :no_guess),
    do: @messages[:no_guess]

  # Correct guess
  def compare(secret_number, secret_number),
    do: @messages[:correct_guess]

  # Close guess
  def compare(secret_number, guess) when is_close(secret_number, guess),
    do: @messages[:close_guess]

  # Guess was above value
  def compare(secret_number, guess) when guess > secret_number,
    do: @messages[:high_guess]

  # Guess was below value
  def compare(secret_number, guess) when guess < secret_number,
    do: @messages[:low_guess]
end
