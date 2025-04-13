defmodule LogLevel do
  @type log_label :: :trace | :debug | :info | :warning | :error | :fatal | :unknown
  @type recipient :: :ops | :dev1 | :dev2

  @missing_legacy_levels [0, 5]

  @doc """
  Returns a log_label appropriate for the given log level and whether
  the log source system is non-legacy.
  """
  @spec to_label(integer, boolean) :: log_label
  def to_label(level, legacy?) do
    cond do
      legacy? -> level |> legacy_label()
      not legacy? -> level |> modern_label()
    end
  end

  @doc """
  Returns which container should be alerted about the occurrence of the
  log given the level informed and whether or not the system is legacy.
  """
  @spec alert_recipient(integer, boolean) :: recipient | false
  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label in [:error, :fatal] -> :ops
      label != :unknown -> false
      legacy? -> :dev1
      not legacy? -> :dev2
    end
  end

  # Returns a log_label appropriate for the given log level on a
  # non-legacy system.
  @spec modern_label(integer) :: log_label
  defp modern_label(level) do
    cond do
      level == 0 -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 -> :fatal
      true -> :unknown
    end
  end

  # Returns a log_label appropriate for the given log level on a legacy
  # system.
  @spec legacy_label(integer) :: log_label
  defp legacy_label(level) do
    cond do
      level in @missing_legacy_levels -> :unknown
      true -> level |> modern_label()
    end
  end
end
