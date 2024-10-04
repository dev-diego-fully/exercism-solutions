defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @default_msg "stack underflow occurred"
    defexception message: @default_msg

    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}

        _ ->
          %StackUnderflowError{
            message: "#{@default_msg}, context: #{value}"
          }
      end
    end
  end

  def divide([0, _]) do
    raise DivisionByZeroError
  end

  def divide(numbers) when length(numbers) < 2 do
    raise StackUnderflowError, "when dividing"
  end

  def divide([a, b | _]) do
    b / a
  end
end
