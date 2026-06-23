using System;
class FinancialForecast
{
  static double PredValue(double currentValue, double growthRate, int years)
  {
    if (years==0)
    {
      return currentValue;
    }
    return PredValue(currentValue*(1+growthRate),growthRate,years-1);
  }
  static void Main()
  {
    double presentValue=10000;
    double growthRate=0.08;
    int years=5;
    double futureValue=PredValue(presentValue,growthRate,years);
    Console.WriteLine("Present Value: "+presentValue);
    Console.WriteLine("Growth Rate: "+(growthRate*100)+"%");
    Console.WriteLine("Years: "+years);
    Console.WriteLine("Predicted Future Value: "+futureValue.ToString("F2"));
    }
}