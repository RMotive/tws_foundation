using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations
{
    /// <inheritdoc />
    public partial class AddingAccountReferencetoEmployeeentity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<long>(
                    name: "Account",
                    table: "Employees",
                    type: "bigint",
                    nullable: true
                );

            migrationBuilder.CreateIndex(
                    name: "IX_Employees_Account",
                    table: "Employees",
                    column: "Account",
                    unique: true,
                    filter: "[Account] IS NOT NULL"
                );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                    name: "IX_Employees_Account",
                    table: "Employees"
                );

            migrationBuilder.DropColumn(
                    name: "Account",
                    table: "Employees"
                );
        }
    }
}
