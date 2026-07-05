using System;
using System.Net;

class Program
{
    static void Main()
    {
        Console.Write("enter your message: ");

        string input = Console.ReadLine() ?? "";

        string sanitizedInput = WebUtility.HtmlEncode(input);

        Console.WriteLine("sanitized output:");
        Console.WriteLine(sanitizedInput);
    }
}