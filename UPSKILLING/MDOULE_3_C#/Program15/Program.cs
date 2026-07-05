using System;

abstract class Vehicle
{
    public abstract void Drive();
}

interface IDrivable
{
    void Start();
}

class Car : Vehicle, IDrivable
{
    public override void Drive()
    {
        Console.WriteLine("car is driving");
    }

    public void Start()
    {
        Console.WriteLine("car is starting");
    }
}

class Program
{
    static void Main()
    {
        Vehicle vehicle = new Car();
        vehicle.Drive();

        IDrivable drivable = new Car();
        drivable.Start();
    }
}