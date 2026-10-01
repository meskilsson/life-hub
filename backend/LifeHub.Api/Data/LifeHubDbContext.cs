using Microsoft.EntityFrameworkCore;
using LifeHub.Api.Models;

namespace LifeHub.Api.Data;

public class LifeHubDbContext(DbContextOptions<LifeHubDbContext> options)
    : DbContext(options)
{
    public DbSet<WeightEntry> WeightEntries { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<WeightEntry>().HasQueryFilter(entry => !entry.IsDeleted);
    }
}