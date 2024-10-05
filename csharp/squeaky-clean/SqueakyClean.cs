using System.Text;

public static class Identifier
{
    public static bool IsLowerGreek(char c)
        => (c >= 'α' && c <= 'ω');
    
    public static string Clean(string identifier)
    {
        StringBuilder cleanedString = new();

        for (int i = 0; i < identifier.Length; i++)
        {
            char c = identifier[i];
            char? prev = i > 0 ? identifier[i - 1] : null;

            if (prev?.Equals('-') ?? false)
            {
                c = char.ToUpper(c);
            }

            if (char.IsWhiteSpace(c))
            {
                cleanedString.Append('_');
                continue;
            }
            if (char.IsControl(c))
            {
                cleanedString.Append("CTRL");
                continue;
            }
            if (IsLowerGreek(c))
            {
                continue;
            }
            if (char.IsLetter(c))
            {
                cleanedString.Append(c);
                continue;
            }

        }

        return cleanedString.ToString();
        
    }

}