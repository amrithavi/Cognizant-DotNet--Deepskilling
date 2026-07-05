using System;
using System.Globalization;
class Program
{
  static void Main()
  {
    int[] numbers={10,20,30,40,50,60};
    //for loop//
    for(int i=0; i< numbers.Length; i++)
    {
      if(numbers[i]==30)
      continue;
      Console.WriteLine(numbers[i]);
      if(numbers[i]==50)
      break;
    }

    //foreach loop//
    foreach(int num in numbers)
    {
      if(num==30)
      continue;
      Console.WriteLine(num);
      if(num==50)
      break;
    }

    //while loop//
    int j=0;
    while(j<numbers.Length)
    {
      if (numbers[j] == 30)
      {
        j++;
        continue;
      }
      Console.WriteLine(numbers[j]);
      if (numbers[j]==50)
        break;
      j++;
    }

    //do while//
    int k=0;
    do
    {
      if (numbers[k] == 30)
      {
        k++;
        continue;
      }
      Console.WriteLine(numbers[k]);
      if(numbers[k]==50)
        break;
      k++;
    } while (k<numbers.Length);
  }
}