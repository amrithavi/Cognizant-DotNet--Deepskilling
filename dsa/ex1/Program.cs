using System;
using System.Collections.Generic;
class Product
{
  public int ProductId {get; set;}
  public string ProductName {get; set;}
  public int Quantity {get; set;}
  public double Price {get; set;}
  public Product(int productId, string productName, int quantity, double price)
  {
    ProductId= productId;
    ProductName = productName;
    Quantity = quantity;
    Price = price;
  }
  public override string ToString ()
  {
    return $"id : {ProductId}, product name : {ProductName}, quantity : {Quantity}, price: {Price}";
  }
}
class Inventory
{
  private Dictionary<int, Product> products = new Dictionary<int, Product>();
  public void AddProduct (Product product)
  {
    products[product.ProductId] = product;
    Console.Write("added");
  }

  public void UpdateProduct (int id, string name, int quantity, double price)
  {
    if (products.ContainsKey(id))
    {
      products[id].ProductName = name;
      products[id].Quantity = quantity;
      products[id].Price = price;
      Console.WriteLine("updated.");
    } else
    {
      Console.WriteLine("not found.");
    }
  }

  public void DeleteProduct (int id)
  {
    if(products.Remove(id))
    {
      Console.WriteLine("deleted");
    } else
    {
      Console.WriteLine("not found");
    }
  }
  public void Display()
  {
    foreach (Product product in products.Values) {
      Console.WriteLine(product);
    }
  }
}

class Program
{
  static void Main()
  {
    Inventory inventory = new Inventory();
    inventory.AddProduct(new Product (101, "laptop", 20, 55000));
    inventory.AddProduct(new Product (102, "mouse", 50, 500));
    Console.Write("data:");
    inventory.Display();
    inventory.UpdateProduct(101, "gaming laptop", 15, 65000);
    Console.Write("updated data:");
    inventory.Display();
    inventory.DeleteProduct(102);
    inventory.Display();
  }
}