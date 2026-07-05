using Microsoft.EntityFrameworkCore;
using RetailInventory;
using EFCore.BulkExtensions;

using var context = new AppDbContext();

var products = await context.Products.ToListAsync();

foreach (var p in products)
    p.StockQuantity += 10;

await context.BulkUpdateAsync(products);

Console.WriteLine("Bulk update complete.");