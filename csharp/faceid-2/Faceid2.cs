using System;
using System.Collections.Generic;

public class FacialFeatures
{
    public string EyeColor { get; }
    public decimal PhiltrumWidth { get; }

    public FacialFeatures(string eyeColor, decimal philtrumWidth)
    {
        EyeColor = eyeColor;
        PhiltrumWidth = philtrumWidth;
    }

    public override bool Equals(object other)
    {
        if (other is FacialFeatures ffother)
        {
            return (this.EyeColor == ffother.EyeColor &&
                    this.PhiltrumWidth == ffother.PhiltrumWidth);
        }
        return false;
    }

    public override int GetHashCode()
        => HashCode.Combine(EyeColor, PhiltrumWidth);

}

public class Identity
{
    public string Email { get; }
    public FacialFeatures FacialFeatures { get; }

    public Identity(string email, FacialFeatures facialFeatures)
    {
        Email = email;
        FacialFeatures = facialFeatures;
    }

    public override bool Equals(object other)
    {
        if (other is Identity iother)
        {
            return this.Email == iother.Email &&
                   this.FacialFeatures.Equals(iother.FacialFeatures);
        }
        return false;
    }

    public override int GetHashCode()
        => HashCode.Combine(this.Email, this.FacialFeatures.GetHashCode());
}

public class Authenticator
{
    private static Identity admin = new Identity("admin@exerc.ism", new FacialFeatures("green", 0.9m));
    private HashSet<Identity> registreds = new HashSet<Identity> { admin };

    public static bool AreSameFace(FacialFeatures faceA, FacialFeatures faceB)
        => faceA.Equals(faceB);

    public bool IsAdmin(Identity identity)
        => admin.Equals(identity);

    public bool Register(Identity identity)
        => this.registreds.Add(identity);

    public bool IsRegistered(Identity identity)
        => this.registreds.Contains(identity);

    public static bool AreSameObject(Identity identityA, Identity identityB)
        => identityA == identityB;
}
