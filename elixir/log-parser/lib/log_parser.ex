defmodule LogParser do
  def valid_line?(line) do
    log_level_regex = ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/

    String.match?(line, log_level_regex)
  end

  def split_line(line) do
    splitter_regex = ~r/<(\~|\*|\=|\-)*>/

    String.split(line, splitter_regex)
  end

  def remove_artifacts(line) do
    eol_n = ~r/end\-of\-line\d+/i
    nothing = ""

    String.replace(line, eol_n, nothing)
  end

  def tag_with_user_name(line) do
    prefix = "[USER]"
    user_regex = ~r/User\s+(\S+)/
    matches = Regex.run(user_regex, line)

    case matches do
      nil -> line
      [_, name] -> "#{prefix} #{name} #{line}"
    end
  end
end
