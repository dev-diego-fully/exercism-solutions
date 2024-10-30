using System;

public static class TelemetryBuffer
{
    public static byte[] ToBuffer(long reading)
    {
        byte[] buffer = new byte[9];
        byte[] bytes = ToBytes(reading);
        buffer[0] = Prefix(reading);
        Array.Copy(bytes, 0, buffer, 1, bytes.Length);
        return buffer;
    }

    public static long FromBuffer(byte[] buffer) => buffer[0] switch
    {
        2 => BitConverter.ToUInt16(buffer.AsSpan()[1..3]),
        4 => BitConverter.ToUInt32(buffer.AsSpan()[1..5]),
        8 => (long)BitConverter.ToUInt64(buffer.AsSpan()[1..9]),
        256 - 2 => BitConverter.ToInt16(buffer.AsSpan()[1..3]),
        256 - 4 => BitConverter.ToInt32(buffer.AsSpan()[1..5]),
        256 - 8 => BitConverter.ToInt64(buffer.AsSpan()[1..9]),
        _ => 0,
    };

    private static byte[] ToBytes(long number) => Prefix(number) switch
    {
        256 - 8 => BitConverter.GetBytes(number),
        256 - 4 => BitConverter.GetBytes((int)number),
        256 - 2 => BitConverter.GetBytes((short)number),
        2 => BitConverter.GetBytes((ushort)number),
        4 => BitConverter.GetBytes((uint)number),
        _ => throw new NotImplementedException("Impossible Exception")
    };

    private static byte Prefix(long number) => number switch
    {
        _ when number < int.MinValue || number > uint.MaxValue => (byte)(256 - 8),
        _ when number > int.MaxValue => (byte)(4),
        _ when number < short.MinValue || number > ushort.MaxValue => (byte)(256 - 4),
        _ when number < ushort.MinValue => (byte)(256 - 2),
        _ => (byte)(2)
    };

}
