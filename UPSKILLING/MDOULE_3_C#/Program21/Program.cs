using System;

class Program
{
    static void CheckObject(object obj)
    {
        if (obj is int number)
        {
            Console.WriteLine("integer value: " + number);
        }
        else if (obj is string text)
        {
            Console.WriteLine("string value: " + text);
        }
        else if (obj is double value)
        {
            Console.WriteLine("double value: " + value);
        }

        string result = obj switch
        {
            int n => "square: " + (n * n),
            string s => "length: " + s.Length,
            double d => "half value: " + (d / 2),
            _ => "unknown type"
        };

        Console.WriteLine(result);
        Console.WriteLine();
    }

    static void Main()
    {
        CheckObject(10);
        CheckObject("hello");
        CheckObject(20.5);
    }
}