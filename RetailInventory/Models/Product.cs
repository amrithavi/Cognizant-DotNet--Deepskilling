namespace RetailInventory;
using System.ComponentModel.DataAnnotations;
public class Product
{
    public ProductDetail? ProductDetail { get; set; }
    public List<Tag> Tags { get; set; } = new();
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public int CategoryId { get; set; }
    public int StockQuantity { get; set; }
    public Category Category { get; set; } = null!;

    [Timestamp]
    public byte[] RowVersion { get; set; } = Array.Empty<byte>();
    
}