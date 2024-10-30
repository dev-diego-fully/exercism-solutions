using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

public class LogParser
{
    public bool IsValidLine(string text)
    {
        string pattern = @"^\[(TRC|DBG|INF|WRN|ERR|FTL)\]*";
        return new Regex(pattern)
            .Match(text)
            .Success;
    }

    public string[] SplitLogLine(string text)
    {
        string pattern = @"<[\^*=-]+>";
        return Regex.Split(text, pattern);
    }

    public int CountQuotedPasswords(string lines)
    {
        string pattern = @""".*password.*""";
        return Regex
            .Matches(lines, pattern, RegexOptions.IgnoreCase)
            .Count;
    }

    public string RemoveEndOfLineText(string line)
    {
        string pattern = @"end-of-line\d+";
        return new Regex(pattern).Replace(line, "");
    }

    public string[] ListLinesWithPasswords(string[] lines)
        => lines.Select(PasswordProcess).ToArray();

    private string PasswordProcess(string line)
    {
        string pattern = @"password\w+";
        Regex regex = new(pattern, RegexOptions.IgnoreCase);
        Match match = regex.Match(line);

        return $"{(match.Success ? match.Value : "--------")}: {line}";
    }
}
