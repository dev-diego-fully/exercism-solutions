using System;
using System.Buffers;

static class Badge
{
    public static string Print(int? id, string name, string? department)
    {
        
        string sufix = department?.ToUpper() ?? "OWNER";
        
        if(id != null)
            return $"[{id}] - {name} - {sufix}";
        
        return $"{name} - {sufix}";

    }
}
