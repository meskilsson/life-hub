namespace LifeHub.Api.Dtos.HourEntries;

public class CreateHourEntryDto
{
    public decimal Hours { get; set; }
    public DateTime RecordedAt { get; set; }
}