using System;
class Person
{
  public string Name;
}
class Program
{
  static void ModifyVal(int number)
  {
    number = 100;
  }
  static void ModifyRef(Person p)
  {
    p.Name="Tony";
  }
  static void Main(string[] args)
  {
    int number = 10;
    Console.WriteLine("value before: " + number);
    ModifyVal(number);
    Console.WriteLine("value after: " + number);

    Person name1 = new Person();
    name1.Name = "IronMan";
    Console.WriteLine("reference before: " + name1.Name);
    ModifyRef(name1);
    Console.WriteLine("reference after: " + name1.Name);

  }
}