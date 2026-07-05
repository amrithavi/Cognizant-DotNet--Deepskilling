using System;
using System.IO;
using System.Text;

class Program
{
    static void Main()
    {
        File.WriteAllText("sample.txt", "hello from filestream");

        using (FileStream fs = new FileStream("sample.txt", FileMode.Open, FileAccess.Read))
        {
            byte[] data = new byte[fs.Length];
            fs.Read(data, 0, data.Length);

            string content = Encoding.UTF8.GetString(data);

            Console.WriteLine("file content:");
            Console.WriteLine(content);
        }

        using (MemoryStream ms = new MemoryStream())
        {
            byte[] bytes = Encoding.UTF8.GetBytes("hello from memorystream");

            ms.Write(bytes, 0, bytes.Length);

            Console.WriteLine("bytes written: " + ms.Length);
        }
    }
}