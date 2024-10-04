defmodule Secrets do
  def secret_add(secret) do
    fn( open ) ->
      open + secret
    end
  end

  def secret_subtract(secret) do
    fn( open ) ->
      open - secret
    end
  end

  def secret_multiply(secret) do
    fn( open ) ->
      open * secret
    end
  end

  def secret_divide(secret) do
    fn( open ) ->
      trunc( open / secret )
    end
  end

  def secret_and(secret) do
    fn( open ) ->
      Bitwise.band( open, secret )
    end
  end

  def secret_xor(secret) do
    fn( open ) ->
      Bitwise.bxor( open, secret )
    end
  end

  def secret_combine( secret_function1, secret_function2 ) do
    fn( open ) ->
      secret_function2.( secret_function1.( open ) )
    end
  end
end
