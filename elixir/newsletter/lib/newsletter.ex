defmodule Newsletter do
  def read_emails(path) do
    case File.read(path) do
      {:error, _} ->
        nil

      {:ok, content} ->
        File.close(path)
        emails = String.split(content, "\n")
        Enum.slice(emails, 0, length(emails) - 1)
    end
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, "#{email}")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path) || []
    logger = open_log(log_path)
    send_and_register = fn email ->
      if send_fun.(email) == :ok do
        log_sent_email(logger, email)
      end
    end
    Enum.each(emails, send_and_register )
    close_log(logger)
  end
end
