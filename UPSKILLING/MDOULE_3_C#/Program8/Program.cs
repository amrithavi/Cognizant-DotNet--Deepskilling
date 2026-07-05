using System;

class Program
{
    static void UpdateRef(ref int num)
    {
        num = num + 10;
    }
    static void UpdateOut(out int num)
    {
        num = 50;
    }
    static void UpdateIn(in int num)
    {
        Console.WriteLine("Value inside in method: " + num);
    }

    static void Main()
    {
        int a = 20;
        Console.WriteLine("before ref: " + a);
        UpdateRef(ref a);
        Console.WriteLine("after ref: " + a);
        int b;
        UpdateOut(out b);
        Console.WriteLine("after out: " + b);
        int c = 30;
        Console.WriteLine("before in: " + c);
        UpdateIn(in c);
        Console.WriteLine("after in: " + c);
    }
}