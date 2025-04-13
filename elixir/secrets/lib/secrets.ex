defmodule Secrets do
  @type secret_function :: (float -> float) | (float -> secret_function)

  @doc """
  Returns a closure that takes one argument and returns the sum of the
  secret value used to construct the closure.
  """
  @spec secret_add(float) :: secret_function
  def secret_add(secret) do
    fn open ->
      open + secret
    end
  end

  @doc """
  Returns a closure that takes an argument and returns the subtraction of
  that argument from the secret value used to construct the closure.
  """
  @spec secret_subtract(float) :: secret_function
  def secret_subtract(secret) do
    fn open ->
      open - secret
    end
  end

  @doc """
  Returns a closure that takes one argument and returns the multiplication
  of that argument with the secret value used to construct the closure.
  """
  @spec secret_multiply(float) :: secret_function
  def secret_multiply(secret) do
    fn open ->
      open * secret
    end
  end

  @doc """
  Returns a closure that takes one argument and returns the division of that
  argument by the secret value used to construct this closure.
  """
  @spec secret_divide(float) :: secret_function
  def secret_divide(secret) do
    fn open ->
      (open / secret) |> trunc()
    end
  end

  @doc """
  Returns a closure that takes one argument and returns a bitwise and of
  that value with the secret value used to construct the closure.
  """
  @spec secret_and(float) :: secret_function
  def secret_and(secret) do
    fn open ->
      open |> Bitwise.band(secret)
    end
  end

  @doc """
  Returns a closure that takes one argument and returns a bitwise xor of
  that argument with the secret value used to construct the closure.
  """
  @spec secret_xor(float) :: secret_function
  def secret_xor(secret) do
    fn open ->
      open |> Bitwise.bxor(secret)
    end
  end

  @doc """
  Returns a closure that takes one argument and returns the result of a
  pipeline of that given argument to the first given function and then the
  second given function.
  """
  @spec secret_combine(secret_function, secret_function) :: secret_function
  def secret_combine(secret_function1, secret_function2) do
    fn open ->
      open
      |> secret_function1.()
      |> secret_function2.()
    end
  end
end
