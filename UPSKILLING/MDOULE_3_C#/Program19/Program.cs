using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        List<string> fruits = new List<string>();

        fruits.Add("apple");
        fruits.Add("banana");
        fruits.Add("mango");

        fruits.Remove("banana");

        Console.WriteLine("list items:");

        foreach (string fruit in fruits)
        {
            Console.WriteLine(fruit);
        }

        Dictionary<int, string> students = new Dictionary<int, string>();

        students.Add(1, "arun");
        students.Add(2, "kiran");
        students.Add(3, "rahul");

        students.Remove(2);

        Console.WriteLine("dictionary items:");

        foreach (KeyValuePair<int, string> student in students)
        {
            Console.WriteLine(student.Key + " : " + student.Value);
        }
    }
}