using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations
{
    /// <inheritdoc />
    public partial class _02092025Yardlogchanges : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Resources",
                columns: table => new {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    File = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    Extension = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: false),
                    YardLog = table.Column<long>(type: "bigint", nullable: true),
                    Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table => {
                    table.PrimaryKey("PK_Resources", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Resources_Yard_Logs_YardLog",
                        column: x => x.YardLog,
                        principalTable: "Yard_Logs",
                        principalColumn: "Id");
                });

            // Migrating existing images in yardlogs to new entity wrap.
            migrationBuilder.Sql(@"
                    INSERT INTO Resources ([File], Extension, YardLog, Timestamp, Name, Description)
                    SELECT 
                        Damage, 'jpg', Id, Timestamp, CONCAT('yardlog_', Truck, '_', 'damage1_', FORMAT(Timestamp, 'yyyy-MM-ddTHH-mm-ss'), '_', Id), CONCAT('Migrated from Yard_Logs.Damage At', CONVERT(VARCHAR(20), GETUTCDATE(), 120))
                    FROM Yard_Logs
                    WHERE Damage IS NOT NULL;

                    INSERT INTO Resources ([File], Extension, YardLog, Timestamp, Name, Description)
                    SELECT 
                        Evidence, 'jpg', Id, Timestamp, CONCAT('yardlog_', Truck, '_', 'truckFront_', FORMAT(Timestamp, 'yyyy-MM-ddTHH-mm-ss'), '_', Id), CONCAT('Migrated from Yard_Logs.Evidence At', CONVERT(VARCHAR(20), GETUTCDATE(), 120))
                    FROM Yard_Logs;
                ");


            migrationBuilder.DropColumn(
                name: "Damage",
                table: "Yard_Logs");

            migrationBuilder.DropColumn(
                name: "Evidence",
                table: "Yard_Logs");

            migrationBuilder.AddColumn<bool>(
                name: "Reservation",
                table: "Yard_Logs",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<long>(
                name: "Resource",
                table: "Sections",
                type: "bigint",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "Resource",
                table: "Locations",
                type: "bigint",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Sections_Resources",
                table: "Sections",
                column: "Resource",
                unique: true,
                filter: "[Resource] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Locations_Resources",
                table: "Locations",
                column: "Resource",
                unique: true,
                filter: "[Resource] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Resources_YardLog",
                table: "Resources",
                column: "YardLog");

            migrationBuilder.AddForeignKey(
                name: "FK_Locations_Resources_Resource",
                table: "Locations",
                column: "Resource",
                principalTable: "Resources",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Resources_Resource",
                table: "Sections",
                column: "Resource",
                principalTable: "Resources",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Locations_Resources_Resource",
                table: "Locations");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Resources_Resource",
                table: "Sections");

            migrationBuilder.DropIndex(
                name: "IX_Resources_YardLog",
                table: "Resources");

            migrationBuilder.DropTable(
                name: "Resources");

            migrationBuilder.DropIndex(
                name: "IX_Sections_Resources",
                table: "Sections");

            migrationBuilder.DropIndex(
                name: "IX_Locations_Resources",
                table: "Locations");

            migrationBuilder.DropColumn(
                name: "Reservation",
                table: "Yard_Logs");

            migrationBuilder.DropColumn(
                name: "Resource",
                table: "Sections");

            migrationBuilder.DropColumn(
                name: "Resource",
                table: "Locations");

            migrationBuilder.AddColumn<byte[]>(
                name: "Damage",
                table: "Yard_Logs",
                type: "varbinary(max)",
                nullable: true);

            migrationBuilder.AddColumn<byte[]>(
                name: "Evidence",
                table: "Yard_Logs",
                type: "varbinary(max)",
                nullable: false,
                defaultValue: new byte[0]);
        }
    }
}
