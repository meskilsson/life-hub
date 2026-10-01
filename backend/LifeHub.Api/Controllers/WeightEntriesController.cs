using LifeHub.Api.Data;
using LifeHub.Api.Dtos.WeightEntries;
using LifeHub.Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LifeHub.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class WeightEntriesController : ControllerBase
{
    private readonly LifeHubDbContext _context;

    public WeightEntriesController(LifeHubDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<WeightEntryResponse>>> GetAll()
    {
        var entries = await _context.WeightEntries
            .OrderByDescending(entry => entry.RecordedAt)
            .Select(entry => new WeightEntryResponse
            {
                Id = entry.Id,
                WeightKg = entry.WeightKg,
                RecordedAt = entry.RecordedAt
            })
            .ToListAsync();

        return Ok(entries);
    }

    [HttpPost]
    public async Task<ActionResult<WeightEntryResponse>> Create(CreateWeightEntryDto dto)
    {
        var entry = new WeightEntry
        {
            WeightKg = dto.WeightKg,
            RecordedAt = dto.RecordedAt
        };

        _context.WeightEntries.Add(entry);

        await _context.SaveChangesAsync();

        var responseDto = new WeightEntryResponse
        {
            Id = entry.Id,
            WeightKg = entry.WeightKg,
            RecordedAt = entry.RecordedAt
        };

        return CreatedAtAction(
            nameof(GetById),
            new { id = entry.Id },
            responseDto
        );
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<WeightEntryResponse>> GetById(int id)
    {
        var entry = await _context.WeightEntries.FindAsync(id);

        if (entry is null)
        {
            return NotFound();
        }

        var dto = new WeightEntryResponse
        {
            Id = entry.Id,
            WeightKg = entry.WeightKg,
            RecordedAt = entry.RecordedAt
        };

        return Ok(dto);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<WeightEntryResponse>> Update(int id, UpdateWeightEntryDto dto)
    {
        var entry = await _context.WeightEntries.FindAsync(id);

        if (entry is null)
        {
            return NotFound();
        }

        entry.WeightKg = dto.WeightKg;
        entry.RecordedAt = dto.RecordedAt;

        await _context.SaveChangesAsync();

        var responseDto = new WeightEntryResponse
        {
            Id = entry.Id,
            WeightKg = entry.WeightKg,
            RecordedAt = entry.RecordedAt
        };

        return Ok(responseDto);
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        var entry = await _context.WeightEntries
            .FirstOrDefaultAsync(entry => entry.Id == id);

        if (entry is null)
        {
            return NotFound();
        }

        entry.IsDeleted = true;
        entry.DeletedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync();

        return NoContent();
    }

    [HttpDelete("{id}/hard")]
    public async Task<IActionResult> HardDelete(int id)
    {
        var entry = await _context.WeightEntries
            .IgnoreQueryFilters()
            .FirstOrDefaultAsync(entry => entry.Id == id);

        if (entry is null)
        {
            return NotFound();
        }

        _context.WeightEntries.Remove(entry);

        await _context.SaveChangesAsync();

        return NoContent();
    }
}
