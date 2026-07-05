using System;
class Program
{
  static void Main(string[] args)
  {
    Console.WriteLine("enter mark: ");
    int marks = Convert.ToInt32(Console.ReadLine());
    string grade;
    if (marks>=90 && marks <= 100)
      grade = "A";
    else if(marks>=80)
      grade = "B";
    else if(marks>=70)
      grade = "C";
    else if(marks>=60)
      grade = "D";
    else if(marks>=50)
      grade = "E";
    else if(marks>=0)
      grade = "F";
    else grade = "invalid";

    Console.WriteLine("if else if:");
    Console.WriteLine($"grade: : {grade}");

    string switchgrade = marks switch
    {
      >=90 and <= 100 => "A",
      >=80 and <90 => "B",
      >=70 and <80 => "C",
      >=60 and <70 => "D",
      _ => "invalid"
    };

    Console.WriteLine("switch case: ");
    Console.WriteLine($"grade:  {switchgrade}" );



  }
}