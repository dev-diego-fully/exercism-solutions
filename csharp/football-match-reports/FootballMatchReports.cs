using System;

public static class PlayAnalyzer
{
    public static string AnalyzeOnField(int shirtNum)
    {
        switch (shirtNum)
        {
            case 1:
                return "goalie";

            case 2:
                return "left back";

            case 3 or 4:
                return "center back";

            case 5:
                return "right back";

            case 6 or 7 or 8:
                return "midfielder";

            case 9:
                return "left wing";

            case 10:
                return "striker";

            case 11:
                return "right wing";

            default:
                throw new ArgumentOutOfRangeException();
        }
    }

    public static string AnalyzeOffField(object report)
    {
        switch (report)
        {

            case int supportersNumber:
                return $"There are {supportersNumber} supporters at the match.";

            case string annoucement:
                return annoucement;

            case Injury injury:
                return $"Oh no! {injury.GetDescription()} Medics are on the field.";

            case Incident incident:
                return incident.GetDescription();
            
            case Manager manager when manager.Club == null:
                return $"{manager.Name}";
            
            case Manager manager:
                return $"{manager.Name} ({manager.Club})";

            default:
                throw new ArgumentException(report.ToString());

        }
    }
}
