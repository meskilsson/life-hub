using LifeHub.Api.Models;

public class HourEntry
{
    public int Id { get; set; }
    public decimal Hours { get; set; }
    public DateTime RecordedAt { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? DeletedAt { get; set; }
}

