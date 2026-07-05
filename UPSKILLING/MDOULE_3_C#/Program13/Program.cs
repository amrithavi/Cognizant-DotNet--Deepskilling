using System;

public record Employee
{
    public string Name { get; init; }
    public int Age { get; init; }
    public string Department { get; init; }
}

class Program
{
    static void Main()
    {
        Employee emp1 = new Employee
        {
            Name = "arun",
            Age = 25,
            Department = "development"
        };

        Employee emp2 = emp1 with
        {
            Age = 26
        };

        Console.WriteLine("original employee");
        Console.WriteLine("name: " + emp1.Name);
        Console.WriteLine("age: " + emp1.Age);
        Console.WriteLine("department: " + emp1.Department);

        Console.WriteLine();

        Console.WriteLine("modified employee");
        Console.WriteLine("name: " + emp2.Name);
        Console.WriteLine("age: " + emp2.Age);
        Console.WriteLine("department: " + emp2.Department);
    }
}