using System;

class BaseClass
{
    public string publicMember = "public member";
    private string privateMember = "private member";
    protected string protectedMember = "protected member";

    public void ShowPrivate()
    {
        Console.WriteLine(privateMember);
    }
}

class DerivedClass : BaseClass
{
    public void Display()
    {
        Console.WriteLine(publicMember);
        Console.WriteLine(protectedMember);
    }
}

class Program
{
    static void Main()
    {
        BaseClass obj1 = new BaseClass();

        Console.WriteLine(obj1.publicMember);
        obj1.ShowPrivate();

        DerivedClass obj2 = new DerivedClass();
        obj2.Display();
    }
}
