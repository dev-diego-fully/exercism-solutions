using System;
using System.Linq;

static class LogLine
{

    private const String LogLevelPredecessor = "[";
    private const String LogLevelSuccessor = "]";
    private const String MessagePredecessor = ": ";

    public static string Message(string logLine)
    {

        const int messageIndex = 1;

        return logLine
            .Split(LogLine.MessagePredecessor)
            .ElementAt( messageIndex )
            .Trim();
    }

    public static string LogLevel(string logLine)
    {
        logLine = logLine.Trim();
        int logLevelStartIndex = 1 + logLine.IndexOf(
            LogLine.LogLevelPredecessor
        );

        int logLevelEndIndex = -1 + logLine.IndexOf(
            LogLine.LogLevelSuccessor
        );

        int logLevelLength = logLevelEndIndex - logLevelStartIndex + 1;

        return logLine
            .Substring(logLevelStartIndex, logLevelLength)
            .ToLower();

    }

    public static string Reformat(string logLine)
    {
        string logLevel = LogLine.LogLevel(logLine);
        string message = LogLine.Message(logLine);

        return $"{message} ({logLevel})";

    }
}
