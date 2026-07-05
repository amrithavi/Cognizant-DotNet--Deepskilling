using System;

class Student
{
    public required string Name { get; set; }
    public required int RollNo { get; set; }
}

class Program
{
    static void Main()
    {
        Student s1 = new Student
        {
            Name = "arun",
            RollNo = 101
        };

        Console.WriteLine("name: " + s1.Name);
        Console.WriteLine("roll no: " + s1.RollNo);

        Student s2 = new Student
        {
            Name = "kiran"
        };
    }
}