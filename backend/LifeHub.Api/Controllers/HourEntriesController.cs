using LifeHub.Api.Data;
using LifeHub.Api.Dtos.HourEntries;
using LifeHub.Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LifeHub.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class HourEntriesController : ControllerBase
{
    private readonly LifeHubDbContext _context;

    public HourEntriesController(LifeHubDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<HourEntryResponse>>> GetAll()
    {
        var entries = await _context.HourEntries
        .OrderByDescending(entry => entry.RecordedAt)
        .Select(entry => new HourEntryResponse
        {
            Id = entry.Id,
            Hours = entry.Hours,
            RecordedAt = entry.RecordedAt
        })
        .ToListAsync();

        return Ok(entries);
    }

    [HttpPost]
    public async Task<ActionResult<HourEntryResponse>> Create(CreateHourEntryDto dto)
    {
        var entry = new HourEntry
        {
            Hours = dto.Hours,
            RecordedAt = dto.RecordedAt
        };

        _context.HourEntries.Add(entry);

        await _context.SaveChangesAsync();

        var responseDto = new HourEntryResponse
        {
            Id = entry.Id,
            Hours = entry.Hours,
            RecordedAt = entry.RecordedAt
        };

        return CreatedAtAction(
            nameof(GetById),
            new { id = entry.Id },
            responseDto
        );
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<HourEntryResponse>> GetById(int id)
    {
        var entry = await _context.HourEntries.FindAsync(id);

        if (entry is null)
        {
            return NotFound();
        }

        var dto = new HourEntry
        {
            Id = entry.Id,
            Hours = entry.Hours,
            RecordedAt = entry.RecordedAt
        };

        return Ok(dto);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<HourEntryResponse>> Update(int id, UpdateHourEntryDto dto)
    {
        var entry = await _context.HourEntries.FindAsync(id);

        if (entry is null)
        {
            return NotFound();
        }

        entry.Hours = dto.Hours;
        entry.RecordedAt = dto.RecordedAt;

        await _context.SaveChangesAsync();

        var responseDto = new HourEntryResponse
        {
            Id = entry.Id,
            Hours = entry.Hours,
            RecordedAt = entry.RecordedAt
        };

        return Ok(responseDto);
    }

    [HttpDelete("{id}/hard")]
    public async Task<IActionResult> HardDelete(int id)
    {
        var entry = await _context.HourEntries
        .IgnoreQueryFilters()
        .FirstOrDefaultAsync(entry => entry.Id == id);

        if (entry is null)
        {
            return NotFound();
        }

        _context.HourEntries.Remove(entry);

        await _context.SaveChangesAsync();

        return NoContent();

    }
}
