using System;

class Product
{
  public int ProductId {get; set;}
  public string ProductName {get; set;}
  public string Category {get; set;}

  public Product (int productId, string productName, string category)
  {
    ProductId = productId;
    ProductName = productName;
    Category = category;
  }
}

class Program
{
  static int Linear(Product[] products, int TargetID)
  {
    for(int i=0; i<products.Length; i++)
    {
      if(products[i].ProductId==TargetID)
      return i;
    }
    return -1;
  }

  static int Binary(Product[] products, int TargetID)
  {
    int left=0;
    int right=products.Length-1;

    while(left<=right)
    {
      int mid = (left+right)/2;
      if(products[mid].ProductId==TargetID)
      {
        return mid;
      } else if(products[mid].ProductId<TargetID)
      {
        left=mid+1;
      } else
      {
        right=mid-1;
      }
    }
    return -1;
  }

  static void Main ()
  {
    Product[] product=
    {
      new Product(105, "Laptop", "Electronics"),
      new Product(102, "Mouse", "Electronics"),
      new Product(108, "Shoes", "Fashion"),
      new Product(101, "Book", "Education"),
      new Product(110, "Watch", "Accessories")
    };

    Product[] sortedproduct =
    {
      new Product(101, "Book", "Education"),
      new Product(102, "Mouse", "Electronics"),
      new Product(105, "Laptop", "Electronics"),
      new Product(108, "Shoes", "Fashion"),
      new Product(110, "Watch", "Accessories")
    };

    int searchID =108;

    int linearResult = Linear(product, searchID);
    if(linearResult!=-1)
      Console.WriteLine("found at: " + product[linearResult].ProductName);
    else
      Console.WriteLine("not found");

    int binaryResult = Binary(sortedproduct, searchID);
    if(binaryResult!=-1)
      Console.WriteLine("found at: " + sortedproduct[binaryResult].ProductName);
    else
      Console.WriteLine("not found");
  }
}
