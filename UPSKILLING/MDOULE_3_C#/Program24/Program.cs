using System;
using System.IO;
using System.Text.Json;

class User
{
    public string Name { get; set; }
    public int Age { get; set; }
    public string Email { get; set; }
}

class Program
{
    static void Main()
    {
        User user = new User
        {
            Name = "arun",
            Age = 21,
            Email = "arun@gmail.com"
        };

        string json = JsonSerializer.Serialize(user);

        File.WriteAllText("user.json", json);

        string jsonFromFile = File.ReadAllText("user.json");

        User deserializedUser = JsonSerializer.Deserialize<User>(jsonFromFile);

        Console.WriteLine("name: " + deserializedUser.Name);
        Console.WriteLine("age: " + deserializedUser.Age);
        Console.WriteLine("email: " + deserializedUser.Email);
    }
}