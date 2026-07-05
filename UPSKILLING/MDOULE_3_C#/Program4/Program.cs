using System;
class Student
{
  public string Name {get; set;} 
  public Student (string name)
  {
    Name= name;
  }
}
class Program
{
  static void Main()
  {
    var Number = 15;
    var Fruit = "Apple";
    Student s1= new ("Jane");

    Console.WriteLine("Number: " + Number);
    Console.WriteLine("Type: " + Number.GetType());
    Console.WriteLine("Fruit: " + Fruit);
    Console.WriteLine("Type: " + Fruit.GetType());
    Console.WriteLine("Student: " + s1.Name);
    Console.WriteLine("Type: " + s1.GetType());
  }
}