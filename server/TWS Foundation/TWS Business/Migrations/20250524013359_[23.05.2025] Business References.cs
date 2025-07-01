using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations
{
    /// <inheritdoc />
    public partial class _23052025BusinessReferences : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Reference",
                table: "Statuses",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Reference",
                table: "Situations",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Reference",
                table: "LoadTypes",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "IX_Statuses_Reference",
                table: "Statuses",
                column: "Reference",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Situations_Reference",
                table: "Situations",
                column: "Reference",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_LoadTypes_Reference",
                table: "LoadTypes",
                column: "Reference",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Statuses_Reference",
                table: "Statuses");

            migrationBuilder.DropIndex(
                name: "IX_Situations_Reference",
                table: "Situations");

            migrationBuilder.DropIndex(
                name: "IX_LoadTypes_Reference",
                table: "LoadTypes");

            migrationBuilder.DropColumn(
                name: "Reference",
                table: "Statuses");

            migrationBuilder.DropColumn(
                name: "Reference",
                table: "Situations");

            migrationBuilder.DropColumn(
                name: "Reference",
                table: "LoadTypes");
        }
    }
}
