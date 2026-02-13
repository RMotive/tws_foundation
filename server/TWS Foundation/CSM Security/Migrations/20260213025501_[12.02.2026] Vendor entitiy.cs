using System;

using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CSM_Security.Migrations
{
    /// <inheritdoc />
    public partial class _12022026Vendorentitiy : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.CreateTable(
                name: "Vendors",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Type = table.Column<int>(type: "int", nullable: false),
                    Timestamp = table.Column<DateTime>(type: "datetime2(7)", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Reference = table.Column<string>(type: "nchar(8)", fixedLength: true, maxLength: 8, nullable: false),
                    IsEnabled = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Vendors", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Accounts_Vendors",
                columns: table => new
                {
                    Account = table.Column<long>(type: "bigint", nullable: false),
                    Vendor = table.Column<long>(type: "bigint", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Accounts_Vendors", x => new { x.Account, x.Vendor });
                    table.ForeignKey(
                        name: "FK_Accounts_Vendors_Accounts_Account",
                        column: x => x.Account,
                        principalTable: "Accounts",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Accounts_Vendors_Vendors_Vendor",
                        column: x => x.Vendor,
                        principalTable: "Vendors",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Accounts_Vendors_Vendor",
                table: "Accounts_Vendors",
                column: "Vendor");

            migrationBuilder.CreateIndex(
                name: "IX_Vendors_Name",
                table: "Vendors",
                column: "Name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Vendors_Reference",
                table: "Vendors",
                column: "Reference",
                unique: true);

            // Default vendor creation.
            migrationBuilder.InsertData(
                table: "Vendors",
                columns: ["Type", "Name", "Description", "Reference", "IsEnabled", "Timestamp"],
                values: [(int)VendorType.Owner, "TW Express", "Vendor owner", "TWSMVO01", true, DateTime.UtcNow]
            );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Accounts_Vendors");

            migrationBuilder.DropTable(
                name: "Vendors");
        }
    }
}
