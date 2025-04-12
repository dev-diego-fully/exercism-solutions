defmodule HelloWorld do
  @hello_word_message "Hello, World!"

  @doc """
  Simply returns "Hello, World!"
  """
  @spec hello :: String.t()
  def hello(),
    do: @hello_word_message
end
