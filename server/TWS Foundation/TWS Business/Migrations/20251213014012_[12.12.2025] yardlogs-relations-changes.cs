using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations
{
    /// <inheritdoc />
    public partial class _12122025yardlogsrelationschanges : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.Sql(@"
            IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Yard_Logs_Drivers_Commons_Driver_CommonId')
                ALTER TABLE Yard_Logs DROP CONSTRAINT FK_Yard_Logs_Drivers_Commons_Driver_CommonId;
            ");

            migrationBuilder.Sql(@"
            IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Yard_Logs_Trailers_Commons_Trailer_CommonId')
                ALTER TABLE Yard_Logs DROP CONSTRAINT FK_Yard_Logs_Trailers_Commons_Trailer_CommonId;
            ");

            migrationBuilder.Sql(@"
            IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Yard_Logs_TrucksCommons_Truck_CommonId')
                ALTER TABLE Yard_Logs DROP CONSTRAINT FK_Yard_Logs_TrucksCommons_Truck_CommonId;
            ");

            migrationBuilder.Sql(@"
            IF EXISTS (SELECT 1 
                        FROM sys.indexes 
                        WHERE name = 'IX_Yard_Logs_Driver_CommonId' 
                            AND object_id = OBJECT_ID('Yard_Logs'))
                DROP INDEX IX_Yard_Logs_Driver_CommonId ON Yard_Logs;
            ");

            migrationBuilder.Sql(@"
            IF EXISTS (SELECT 1 
                        FROM sys.indexes 
                        WHERE name = 'IX_Yard_Logs_Trailer_CommonId' 
                            AND object_id = OBJECT_ID('Yard_Logs'))
                DROP INDEX IX_Yard_Logs_Trailer_CommonId ON Yard_Logs;
            ");

            migrationBuilder.Sql(@"
            IF EXISTS (SELECT 1 
                        FROM sys.indexes 
                        WHERE name = 'IX_Yard_Logs_Truck_CommonId' 
                            AND object_id = OBJECT_ID('Yard_Logs'))
                DROP INDEX IX_Yard_Logs_Truck_CommonId ON Yard_Logs;
            ");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Guard",
                table: "Yard_Logs");

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Guard",
                table: "Yard_Logs",
                column: "Guard");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Driver",
                table: "Yard_Logs");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Trailer",
                table: "Yard_Logs");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Truck",
                table: "Yard_Logs");

            migrationBuilder.Sql(@"
            IF EXISTS (
                SELECT 1 
                FROM sys.columns 
                WHERE Name = 'Driver_CommonId' 
                  AND Object_ID = Object_ID('Yard_Logs')
            )
                ALTER TABLE Yard_Logs DROP COLUMN Driver_CommonId;
            ");

            migrationBuilder.Sql(@"
            IF EXISTS (
                SELECT 1 
                FROM sys.columns 
                WHERE Name = 'Trailer_CommonId' 
                  AND Object_ID = Object_ID('Yard_Logs')
            )
                ALTER TABLE Yard_Logs DROP COLUMN Trailer_CommonId;
            ");

            migrationBuilder.Sql(@"
            IF EXISTS (
                SELECT 1 
                FROM sys.columns 
                WHERE Name = 'Truck_CommonId' 
                  AND Object_ID = Object_ID('Yard_Logs')
            )
                ALTER TABLE Yard_Logs DROP COLUMN Truck_CommonId;
            ");

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Driver",
                table: "Yard_Logs",
                column: "Driver");

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Trailer",
                table: "Yard_Logs",
                column: "Trailer");

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Truck",
                table: "Yard_Logs",
                column: "Truck");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Guard",
                table: "Yard_Logs");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Driver",
                table: "Yard_Logs");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Trailer",
                table: "Yard_Logs");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Truck",
                table: "Yard_Logs");

            migrationBuilder.AddColumn<long>(
                name: "Driver_CommonId",
                table: "Yard_Logs",
                type: "bigint",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "Trailer_CommonId",
                table: "Yard_Logs",
                type: "bigint",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "Truck_CommonId",
                table: "Yard_Logs",
                type: "bigint",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Guard",
                table: "Yard_Logs",
                column: "Guard",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Driver",
                table: "Yard_Logs",
                column: "Driver",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Driver_CommonId",
                table: "Yard_Logs",
                column: "Driver_CommonId");

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Trailer",
                table: "Yard_Logs",
                column: "Trailer",
                unique: true,
                filter: "[Trailer] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Trailer_CommonId",
                table: "Yard_Logs",
                column: "Trailer_CommonId");

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Truck",
                table: "Yard_Logs",
                column: "Truck",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Truck_CommonId",
                table: "Yard_Logs",
                column: "Truck_CommonId");

            migrationBuilder.AddForeignKey(
                name: "FK_Yard_Logs_Drivers_Commons_Driver_CommonId",
                table: "Yard_Logs",
                column: "Driver_CommonId",
                principalTable: "Drivers_Commons",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Yard_Logs_Trailers_Commons_Trailer_CommonId",
                table: "Yard_Logs",
                column: "Trailer_CommonId",
                principalTable: "Trailers_Commons",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Yard_Logs_TrucksCommons_Truck_CommonId",
                table: "Yard_Logs",
                column: "Truck_CommonId",
                principalTable: "TrucksCommons",
                principalColumn: "Id");
        }
    }
}
