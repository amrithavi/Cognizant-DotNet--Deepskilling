using System;
using System.Collections.Generic;
using System.Linq;

class Order
{
    public int OrderId { get; set; }
    public string CustomerName { get; set; }
    public double TotalAmount { get; set; }
}

class Program
{
    static void Main()
    {
        List<Order> orders = new List<Order>
        {
            new Order { OrderId = 1, CustomerName = "arun", TotalAmount = 1200 },
            new Order { OrderId = 2, CustomerName = "kiran", TotalAmount = 800 },
            new Order { OrderId = 3, CustomerName = "rahul", TotalAmount = 1500 }
        };

        var filteredOrders = orders
            .Where(o => o.TotalAmount > 1000)
            .Select(o => new
            {
                o.OrderId,
                o.CustomerName
            });

        foreach (var order in filteredOrders)
        {
            Console.WriteLine("order id: " + order.OrderId);
            Console.WriteLine("customer name: " + order.CustomerName);
            Console.WriteLine();
        }
    }
}