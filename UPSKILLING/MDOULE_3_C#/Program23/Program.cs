using System;
using System.Threading.Tasks;

class Program
{
    static async Task<string> UploadFileAsync()
    {
        try
        {
            await Task.Delay(3000);
            return "file uploaded successfully";
        }
        catch (Exception ex)
        {
            return "error: " + ex.Message;
        }
    }

    static async Task Main()
    {
        Console.WriteLine("uploading file...");

        string result = await UploadFileAsync();

        Console.WriteLine(result);
    }
}