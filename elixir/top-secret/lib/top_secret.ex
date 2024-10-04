defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({definition, _, [declaration, _]} = ast, acc)
      when definition in [:def, :defp] do
    fun_name = get_function_name(declaration)
    fun_arity = get_function_arity(declaration)
    message = function_message(fun_name, fun_arity)

    {ast, [message | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp get_function_name(def_args) do
    case def_args do
      {:when, _, [{name, _, _} | _]} -> Atom.to_string(name)
      {name, _, _} -> Atom.to_string(name)
    end
  end

  defp get_function_arity(def_args) do
    case def_args do
      {:when, _, [{_, _, args} | _]} -> length(args)
      {_, _, args} when is_list(args) -> length(args)
      _ -> 0
    end
  end

  defp function_message(fun_name, arity) do
    String.slice(fun_name, 0, arity)
  end

  def decode_secret_message(code) do
    ast = to_ast(code)
    {_, message_parts} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    message_parts |> Enum.reverse() |> Enum.join()
  end
end
