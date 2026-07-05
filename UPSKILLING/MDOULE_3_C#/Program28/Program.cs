using System;
using System.Diagnostics;

class Logger
{
    public static void Log(string message)
    {
        Console.WriteLine(message);
        Trace.WriteLine(message);
    }
}

class Program
{
    static void Main()
    {
        Trace.Listeners.Add(new TextWriterTraceListener("log.txt"));
        Trace.AutoFlush = true;

        Logger.Log("application started");
        Logger.Log("processing data");
        Logger.Log("application ended");

        Trace.Close();
    }
}