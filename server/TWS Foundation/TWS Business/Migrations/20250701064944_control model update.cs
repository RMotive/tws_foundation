using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations
{
    /// <inheritdoc />
    public partial class controlmodelupdate : Migration
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
}
