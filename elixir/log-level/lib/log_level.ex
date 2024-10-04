defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      legacy? -> cond do
        level == 0 or level == 5 -> :unknown
        true -> to_label( level, not legacy? )
      end
      not legacy? -> cond do
        level == 0 -> :trace
        level == 1 -> :debug
        level == 2 -> :info
        level == 3 -> :warning
        level == 4 -> :error
        level == 5 -> :fatal
        true -> :unknown
      end
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label( level, legacy? )
    cond do
      label == :unknown -> cond do
        legacy? -> :dev1
        not legacy? -> :dev2
      end
      label == :error or label == :fatal -> :ops
      true -> false
    end
  end
end
