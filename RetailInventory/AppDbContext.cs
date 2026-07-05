using Microsoft.EntityFrameworkCore;

namespace RetailInventory;

public class AppDbContext : DbContext
{
    public DbSet<Product> Products { get; set; }
    public DbSet<Category> Categories { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer("Server=.\\SQLEXPRESS;Database=RetailInventoryDb;Trusted_Connection=True;TrustServerCertificate=True;");
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Category>().HasData(
            new Category { Id = 3, Name = "Electronics" },
            new Category { Id = 4, Name = "Groceries" }
        );

        modelBuilder.Entity<Product>().HasData(
            new Product { Id = 3, Name = "Smartphone", Price = 25000, CategoryId = 3, StockQuantity = 50 },
            new Product { Id = 4, Name = "Wheat Flour", Price = 800, CategoryId = 4, StockQuantity = 100 }
        );

        modelBuilder.Entity<Product>()
        .HasOne(p => p.ProductDetail)
        .WithOne(pd => pd.Product)
        .HasForeignKey<ProductDetail>(pd => pd.ProductId);
    }
}