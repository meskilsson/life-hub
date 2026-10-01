using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LifeHub.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddSoftDeleteToWeightEntries : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "DeletedAt",
                table: "WeightEntries",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "WeightEntries",
                type: "boolean",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DeletedAt",
                table: "WeightEntries");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "WeightEntries");
        }
    }
}
