using System;

enum LogLevel
{
    Trace = 1,
    Debug = 2,
    Info = 4,
    Warning = 5,
    Error = 6,
    Fatal = 42,
    Unknown = 0
}

static class LogLine
{
    private static string LogLevelOf(string logLine)
    {
        int logLevelStart = logLine.IndexOf("[") + 1;
        int logLevelEnd = logLine.IndexOf("]") - 1;

        return logLine.Substring(logLevelStart, logLevelEnd);
    }

    public static LogLevel ParseLogLevel(string logLine)
    {
        switch(LogLevelOf( logLine )) {
            case "TRC":
                return LogLevel.Trace;

            case "DBG":
                return LogLevel.Debug;

            case "INF":
                return LogLevel.Info;

            case "WRN":
                return LogLevel.Warning;

            case "ERR":
                return LogLevel.Error;

            case "FTL":
                return LogLevel.Fatal;
            
            default:
                return LogLevel.Unknown;
        }
    }

    public static string OutputForShortLog(LogLevel logLevel, string message)
        => $"{(int)logLevel}:{message}";
}
