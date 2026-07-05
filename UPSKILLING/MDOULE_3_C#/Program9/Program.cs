using System;

class Program
{
    static void CalculateFactorial(int n)
    {
        int Factorial(int num)
        {
            if (num <= 1)
                return 1;

            return num * Factorial(num - 1);
        }

        Console.WriteLine("Factorial of " + n + " is " + Factorial(n));
    }

    static void Main()
    {
        CalculateFactorial(5);
    }
}