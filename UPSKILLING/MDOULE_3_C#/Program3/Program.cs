using System;
class Person (string name, int age)
{
  public string Name {get; set;} = name;
  public int Age {get; set;} = age;

  public void Display()
  {
    Console.WriteLine("Name: " + Name);
    Console.WriteLine("Age: " + Age);
  }
}

class Program()
{
  static void Main()
  {
    Person p1 = new Person("jane", 20);
    p1.Display();
  }
}