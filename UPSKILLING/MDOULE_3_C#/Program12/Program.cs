using System;

class Product
{
    public string Name { get; set; }

    private double price;

    public double Price
    {
        get { return price; }
        set
        {
            if (value >= 0)
                price = value;
            else
                Console.WriteLine("price cannot be negative");
        }
    }
}

class Program
{
    static void Main()
    {
        Product p = new Product();

        p.Name = "laptop";
        p.Price = 50000;

        Console.WriteLine("name: " + p.Name);
        Console.WriteLine("price: " + p.Price);

        p.Price = -1000;

        Console.WriteLine("price after validation: " + p.Price);
    }
}