using System.Collections.Concurrent;

class Order
{
  public int OrderId {get; set;}
  public string CustomerName {get; set;}
  public double TotalPrice{get; set;}

  public Order (int orderId, string customerId, double totalPrice)
  {
    OrderId = orderId;
    CustomerName = customerId;
    TotalPrice = totalPrice;
  }

  public override string ToString()
  {
    return $" Id: {OrderId}, Custmer Name:  {CustomerName}, TotalPrice: {TotalPrice}";
  }
}

class Program
{
  static void BubbleSort (Order[] orders)
  {
    int n=orders.Length;
    for (int i=0; i<n;i++)
    {
      for (int j=0; j<n-i-1; j++)
      {
        if(orders[j].TotalPrice > orders[j+1].TotalPrice)
        {
          Order temp = orders[j];
          orders[j] = orders[j+1];
          orders[j+1] = temp;
        }
      }
    }
  }

  static void QuickSort (Order[] orders, int low, int high)
  {
    if(low<high)
    {
      int pivotindex = Partition(orders, low, high);
      QuickSort(orders, low, pivotindex-1);
      QuickSort(orders, pivotindex+1, high);
    }
  }
  static int Partition(Order[] orders, int low, int high)
  {
    double pivot = orders[high].TotalPrice;
    int i=low-1;
    for(int j=low; j<high; j++)
    {
      if(orders[j].TotalPrice < pivot) {
        i++;
        Order temp = orders[i];
        orders[i]=orders[j];
        orders[j]=temp;
      }
    }
    Order swap = orders[i+1];
    orders[i+1]=orders[high];
    orders[high]=swap;
    return i+1;
  }
  static void DisplayOrders(Order[] orders)
  {
    foreach(Order order in orders)
    {
      Console.WriteLine(order);
    }
  }
  static void Main()
  {
    Order[] orders =
    {
      new Order(101,"alice",2500),
      new Order(102,"bob",1200),
      new Order(103,"Charlie",4500)
    };
    Console.WriteLine("original:");
    DisplayOrders(orders);
    Console.WriteLine("choose 1 or 2: ");
    int choice = Convert.ToInt32(Console.ReadLine());
    switch(choice)
    {
      case 1:
      BubbleSort(orders);
      Console.WriteLine("bubble sort: ");
      break;

      case 2:
      QuickSort(orders, 0, orders.Length-1);
      Console.WriteLine("quick sort: ");
      break;
    }
    DisplayOrders(orders);
  }
}