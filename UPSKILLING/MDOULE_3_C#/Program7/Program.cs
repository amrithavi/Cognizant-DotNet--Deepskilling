using System;
class Program
{
  static int Calculate(int a, int b)
  {
    return a+b;
  }
  static double Calculate(double a, double b, double c)
  {
    return a+b+c;
  }
  static void Main()
  {
    int total1= Calculate(14,36);
    double total2=Calculate(24.84,51.63,34.55);

    Console.WriteLine("two int: " + total1);
    Console.WriteLine("three double: " + total2);

  }
}