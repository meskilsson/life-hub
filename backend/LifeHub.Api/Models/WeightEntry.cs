namespace LifeHub.Api.Models;

public class WeightEntry
{
    public int Id { get; set; }
    public decimal WeightKg { get; set; }
    public DateTime RecordedAt { get; set; }

    public bool IsDeleted { get; set; }
    public DateTime? DeletedAt { get; set; }
}