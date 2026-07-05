using System;

class Shape
{
    public virtual void Draw()
    {
        Console.WriteLine("drawing a shape");
    }
}

class Circle : Shape
{
    public override void Draw()
    {
        Console.WriteLine("drawing a circle");
    }
}

class Rectangle : Shape
{
    public override void Draw()
    {
        Console.WriteLine("drawing a rectangle");
    }
}

class Program
{
    static void Main()
    {
        Shape circle = new Circle();
        Shape rectangle = new Rectangle();

        circle.Draw();
        rectangle.Draw();
    }
}