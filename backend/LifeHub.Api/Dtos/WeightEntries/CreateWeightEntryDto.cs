namespace LifeHub.Api.Dtos.WeightEntries;

public class CreateWeightEntryDto
{
    public decimal WeightKg { get; set; }
    public DateTime RecordedAt { get; set; }
}