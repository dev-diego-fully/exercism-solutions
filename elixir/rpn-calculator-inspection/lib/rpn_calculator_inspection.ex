defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    %{
      input: input,
      pid: spawn_link(fn -> calculator.(input) end)
    }
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _reason} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    starter = fn input ->
      start_reliability_check(calculator, input)
    end

    awaiter = &await_reliability_check_result/2

    original_trap_flag = Process.flag(:trap_exit, true)

    results =
      inputs
      |> Enum.map(starter)
      |> Enum.reduce(%{}, awaiter)

    true = Process.flag(:trap_exit, original_trap_flag)

    results
  end

  def correctness_check(calculator, inputs) do
    asyncer = fn input ->
      do_calc = fn -> calculator.(input) end
      Task.async(do_calc)
    end

    awaiter = fn task ->
      Task.await(task, 100)
    end

    inputs
    |> Enum.map(asyncer)
    |> Enum.map(awaiter)
  end
end
