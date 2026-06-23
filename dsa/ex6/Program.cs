using System;
public class Book
{
  public int BookId {get; set;}
  public string Title {get; set;}
  public string Author {get;set;}
  public Book(int bookId, string title, string author)
  {
    BookId=bookId;
    Title=title;
    Author=author;
  }
  public override string ToString()
  {
    return $"id:{BookId}, book title:{Title}, book author:{Author}";
  }
}

class LibraryManagement
{
  public static Book Linearsearch(Book[] books, string title)
  {
    foreach(Book book in books)
    {
      if(book.Title.Equals(title, StringComparison.OrdinalIgnoreCase))
      {
        return book;
      }
    }
    return null;
  }

  public static Book Binarysearch(Book[] books, string title)
  {
    int low=0;
    int high=books.Length-1;
    while(low<=high)
    {
      int mid = (low+high)/2;
      int result=string.Compare(books[mid].Title, title, StringComparison.OrdinalIgnoreCase);
      if (result==0)
      {
        return books[mid];
      } else if (result<0)
      {
        low=mid+1;
      } else
      {
        high=mid-1;
      }
    }
    return null;
  }

  static void Main()
  {
    Book[] books =
    {
      new Book(101, "harry potter", "j k rowling"),
      new Book(102, "percy jackson", "rick riordan"),
      new Book(103, "the housemain", "frieda mcfadden"),
      new Book(104, "twilight", "stephenie meyer"),
      new Book(105, "the hobbit", "j r r tolkien")
    };
    Console.Write("enter book title:");
    string searchTitle=Console.ReadLine();
    Console.WriteLine("Linear:");
    Book linearResult=Linearsearch(books, searchTitle);
    if(linearResult!=null)
      Console.WriteLine(linearResult);
    else 
      Console.WriteLine("not found");

    Console.WriteLine("Binary:");
    Book binaryResult=Binarysearch(books, searchTitle);
    if(binaryResult !=null)
      Console.WriteLine(binaryResult);
    else 
    Console.WriteLine("not found");
  }
}