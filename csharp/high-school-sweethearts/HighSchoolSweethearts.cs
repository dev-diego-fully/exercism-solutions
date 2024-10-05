using System;
using System.Globalization;


public static class HighSchoolSweethearts
{

    const string HEART =
@"
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     {0} +  {1}    **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
";
    public static string DisplaySingleLine(string studentA, string studentB)
        => $"                  {studentA} ♡ {studentB}                    ";

    public static string DisplayBanner(string studentA, string studentB)
        => string.Format(HEART, studentA, studentB);

    public static string DisplayGermanExchangeStudents(string studentA, string studentB, DateTime start, float hours)
    {
        string strDate = start.ToString("dd.MM.yyyy");
        string strHours = hours.ToString("N2", new CultureInfo("de-DE"));

        return $"{studentA} and {studentB} have been dating since {strDate} - that's {strHours} hours";
    }

}
