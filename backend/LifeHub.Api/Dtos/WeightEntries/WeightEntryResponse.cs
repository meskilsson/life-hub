namespace LifeHub.Api.Dtos.WeightEntries;

public class WeightEntryResponse
{
    public int Id { get; set; }
    public decimal WeightKg { get; set; }

    public DateTime RecordedAt { get; set; }
}