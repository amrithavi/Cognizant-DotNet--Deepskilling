#nullable enable

using System;

class Contact
{
    public string? Name { get; set; }
    public string? PhoneNumber { get; set; }
}

class Program
{
    static void Main()
    {
        Contact? contact1 = new Contact
        {
            Name = "arun",
            PhoneNumber = "9876543210"
        };

        Contact? contact2 = null;

        Console.WriteLine("contact 1 name: " + (contact1?.Name ?? "not available"));
        Console.WriteLine("contact 2 name: " + (contact2?.Name ?? "not available"));
    }
}