using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations
{
    /// <inheritdoc />
    public partial class _12022026Vendorentitiy : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder) {
            migrationBuilder.CreateTable(
                name: "YardLog_Vendors",
                columns: table => new {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    VendorId = table.Column<long>(type: "bigint", nullable: false),
                    YardlogId = table.Column<long>(type: "bigint", nullable: false),
                    Timestamp = table.Column<DateTime>(type: "datetime2(7)", nullable: false, defaultValueSql: "GETUTCDATE()")
                },
                constraints: table => {
                    table.PrimaryKey("PK_YardLog_Vendors", x => x.Id);
                    table.ForeignKey(
                        name: "FK_YardLog_Vendors_Yard_Logs_YardlogId",
                        column: x => x.YardlogId,
                        principalTable: "Yard_Logs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_YardLog_Vendors_YardlogId",
                table: "YardLog_Vendors",
                column: "YardlogId");

            // Validation for default vendor auto inserts for current yard logs.
            // Vendors migration must be applied on Security db for this.
            migrationBuilder.Sql(@"
                IF NOT EXISTS (SELECT 1 FROM [CSM Security].[dbo].[Vendors] WHERE Reference = 'TWSMVO01')
                BEGIN
                      INSERT INTO [CSM Security].[dbo].[Vendors] (Type, Name, Description, Reference, IsEnabled, Timestamp)
                      VALUES (0, 'TW Express', 'Vendor owner', 'TWSMVO01', 1, GETUTCDATE());

                END;

                DECLARE @VendorId BIGINT;
                SELECT TOP 1 @VendorId = Id FROM [CSM Security].[dbo].[Vendors] WHERE Reference = 'TWSMVO01';

                INSERT INTO YardLog_Vendors (VendorId, YardlogId, Timestamp)
                SELECT @VendorId, Id, GETUTCDATE()
                FROM Yard_Logs;
            ");

        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "YardLog_Vendors");
        }
    }
}
