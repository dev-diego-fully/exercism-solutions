using System;

public static class PhoneNumber
{
    public static (bool IsNewYork, bool IsFake, string LocalNumber) Analyze(string phoneNumber)
    {
        string[] splittedNumber = phoneNumber.Split("-");

        (string dialingCode, string prefix, string number) number = (
            splittedNumber[0], splittedNumber[1], splittedNumber[2]
        );

        return (
            number.dialingCode == "212",
            number.prefix == "555",
            number.number
        );

    }

    public static bool IsFake((bool IsNewYork, bool IsFake, string LocalNumber) phoneNumberInfo)
        => phoneNumberInfo.IsFake;
}
