#nullable enable

using System;

class Person
{
    public string? Name { get; set; }
    public string? City { get; set; }
}

class Program
{
    static void Main()
    {
        Person? person = null;

        Console.WriteLine("name: " + (person?.Name ?? "not available"));

        if (person == null)
        {
            Console.WriteLine("person object is null");
        }

        person = new Person
        {
            Name = "arun",
            City = "chennai"
        };

        Console.WriteLine("name: " + (person?.Name ?? "not available"));
        Console.WriteLine("city: " + (person?.City ?? "not available"));

        if (person != null)
        {
            Console.WriteLine("person object is not null");
        }
    }
}