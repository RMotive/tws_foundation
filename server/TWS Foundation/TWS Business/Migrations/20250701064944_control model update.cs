using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations;

/// <inheritdoc />
#pragma warning disable CS8981 // The type name only contains lower-cased ascii characters. Such names may become reserved for the language.
public partial class controlmodelupdate : Migration
#pragma warning restore CS8981 // The type name only contains lower-cased ascii characters. Such names may become reserved for the language.
{
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.DropIndex(
            name: "IX_LoadTypes_Name",
            table: "LoadTypes");

        migrationBuilder.RenameColumn(
            name: "Lastname",
            table: "Identifications",
            newName: "LastName");
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.RenameColumn(
            name: "LastName",
            table: "Identifications",
            newName: "Lastname");

        migrationBuilder.CreateIndex(
            name: "IX_LoadTypes_Name",
            table: "LoadTypes",
            column: "Name",
            unique: true);
    }
}
