#nullable disable

using Microsoft.EntityFrameworkCore.Migrations;

namespace TWS_Business.Migrations {
    public partial class _23052025BusinessReferences : Migration {
        protected override void Up(MigrationBuilder migrationBuilder) {
            // Add nullable columns first
            migrationBuilder.AddColumn<string>(
                name: "Reference",
                table: "Statuses",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Reference",
                table: "Situations",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Reference",
                table: "LoadTypes",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: true);

            // Populate new columns with random 8-char references
            migrationBuilder.Sql(@"
                UPDATE Statuses
                SET Reference = LEFT(REPLACE(NEWID(), '-', ''), 8)
                WHERE Reference IS NULL;

                UPDATE Situations
                SET Reference = LEFT(REPLACE(NEWID(), '-', ''), 8)
                WHERE Reference IS NULL;

                UPDATE LoadTypes
                SET Reference = LEFT(REPLACE(NEWID(), '-', ''), 8)
                WHERE Reference IS NULL;
            ");

            // Alter columns to be non-nullable now that they're populated
            migrationBuilder.AlterColumn<string>(
                name: "Reference",
                table: "Statuses",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nchar(8)",
                oldFixedLength: true,
                oldMaxLength: 8,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Reference",
                table: "Situations",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nchar(8)",
                oldFixedLength: true,
                oldMaxLength: 8,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Reference",
                table: "LoadTypes",
                type: "nchar(8)",
                fixedLength: true,
                maxLength: 8,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nchar(8)",
                oldFixedLength: true,
                oldMaxLength: 8,
                oldNullable: true);

            // Create unique indexes
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

        protected override void Down(MigrationBuilder migrationBuilder) {
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