using System;

class Program
{
    static (int, string) GetData()
    {
        return (101, "arun");
    }

    static void Main()
    {
        (int id, string name) = GetData();

        Console.WriteLine("id: " + id);
        Console.WriteLine("name: " + name);
    }
}