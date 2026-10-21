namespace LifeHub.Api.Dtos.HourEntries;

public class HourEntryResponse
{
    public int Id { get; set; }
    public decimal Hours { get; set; }
    public DateTime RecordedAt { get; set; }
}