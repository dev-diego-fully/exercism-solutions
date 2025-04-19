defmodule TakeANumber do
  @doc """
  Returns a process that generates integers starting from 0 and
  stops when requested.
  This process:
  - Generates numbers only when requested with {:take_a_number, sender_pid}
  - Reports the last integer generated with {:take_a_number, sender_pid}
  - Can be stopped with :stop, returning :stopped
  - Ignores any other messages received.
  """
  @spec start() :: pid()
  def start(),
    do: spawn(&process_loop/0)

  # Process loop described in the start documentation.
  # It has the generated integer as its internal state. This internal state
  # is automatically initialized with 0 and incremented whenever a new number
  # is generated.
  @spec process_loop(integer) :: :stopped
  defp process_loop(state \\ 0) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        process_loop(state)

      {:take_a_number, sender_pid} ->
        send(sender_pid, state + 1)
        process_loop(state + 1)

      :stop ->
        :stopped

      _ ->
        process_loop(state)
    end
  end
end
