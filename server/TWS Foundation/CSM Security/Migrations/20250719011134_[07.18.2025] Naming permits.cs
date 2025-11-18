using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CSM_Security.Migrations
{
    /// <inheritdoc />
    public partial class _07182025Namingpermits : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Description",
                table: "Permits",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "Permits",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.Sql(
                @"UPDATE Permits 
                SET Name = CONCAT('Permit_', NEWID()) 
                WHERE Name = '' OR Name IS NULL");


            migrationBuilder.CreateIndex(
                name: "IX_Permits_Name",
                table: "Permits",
                column: "Name",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Permits_Name",
                table: "Permits");

            migrationBuilder.DropColumn(
                name: "Description",
                table: "Permits");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "Permits");
        }
    }
}
