using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations
{
    /// <inheritdoc />
    public partial class _30012025databasepackagerefactorchanges : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.DropForeignKey(
                name: "FK_Drivers_Drivers_Commons_Common",
                table: "Drivers");

            migrationBuilder.DropForeignKey(
                name: "FK_Drivers_Externals_Drivers_Commons_Common",
                table: "Drivers_Externals");

            migrationBuilder.DropForeignKey(
                name: "FK_Trailers_Trailers_Commons_Common",
                table: "Trailers");

            migrationBuilder.DropForeignKey(
                name: "FK_Trailers_Externals_Trailers_Commons_Common",
                table: "Trailers_Externals");

            migrationBuilder.DropForeignKey(
                name: "FK_Trucks_TrucksCommons_Common",
                table: "Trucks");

            migrationBuilder.DropForeignKey(
                name: "FK_Trucks_Externals_TrucksCommons_Common",
                table: "Trucks_Externals");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Guard",
                table: "Yard_Logs");

            migrationBuilder.RenameColumn(
                name: "Common",
                table: "Trucks_Externals",
                newName: "Bridge");

            migrationBuilder.RenameIndex(
                name: "IX_Trucks_Externals_Common",
                table: "Trucks_Externals",
                newName: "IX_Trucks_Externals_Bridge");

            migrationBuilder.RenameColumn(
                name: "Common",
                table: "Trucks",
                newName: "Bridge");

            migrationBuilder.RenameIndex(
                name: "IX_Trucks_Common",
                table: "Trucks",
                newName: "IX_Trucks_Bridge");

            migrationBuilder.RenameColumn(
                name: "Common",
                table: "Trailers_Externals",
                newName: "Bridge");

            migrationBuilder.RenameIndex(
                name: "IX_Trailers_Externals_Common",
                table: "Trailers_Externals",
                newName: "IX_Trailers_Externals_Bridge");

            migrationBuilder.RenameColumn(
                name: "Common",
                table: "Trailers",
                newName: "Bridge");

            migrationBuilder.RenameIndex(
                name: "IX_Trailers_Common",
                table: "Trailers",
                newName: "IX_Trailers_Bridge");

            migrationBuilder.RenameColumn(
                name: "Common",
                table: "Drivers_Externals",
                newName: "Bridge");

            migrationBuilder.RenameIndex(
                name: "IX_Drivers_Externals_Common",
                table: "Drivers_Externals",
                newName: "IX_Drivers_Externals_Bridge");

            migrationBuilder.RenameColumn(
                name: "Common",
                table: "Drivers",
                newName: "Bridge");

            migrationBuilder.RenameIndex(
                name: "IX_Drivers_Common",
                table: "Drivers",
                newName: "IX_Drivers_Bridge");

            migrationBuilder.Sql(@"
                UPDATE Statuses
                SET Name = LEFT(Name, 100)
                WHERE LEN(Name) > 100;
            ");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Statuses",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.Sql(@"
                UPDATE Statuses
                SET Description = LEFT(Description, 200)
                WHERE LEN(Description) > 200;
            ");

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                table: "Statuses",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsEnabled",
                table: "Statuses",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.Sql(@"
                UPDATE Situations
                SET Name = LEFT(Name, 100)
                WHERE LEN(Name) > 100;
            ");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Situations",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.Sql(@"
                UPDATE Situations
                SET Description = LEFT(Description, 200)
                WHERE LEN(Description) > 200;
            ");

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                table: "Situations",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsEnabled",
                table: "Situations",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.Sql(@"
                UPDATE LoadTypes
                SET Name = LEFT(Name, 100)
                WHERE LEN(Name) > 100;
            ");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "LoadTypes",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.Sql(@"
                UPDATE LoadTypes
                SET Description = LEFT(Description, 200)
                WHERE LEN(Description) > 200;
            ");

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                table: "LoadTypes",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Guard",
                table: "Yard_Logs",
                column: "Guard");

            migrationBuilder.CreateIndex(
                name: "IX_Statuses_Name",
                table: "Statuses",
                column: "Name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Situations_Name",
                table: "Situations",
                column: "Name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_LoadTypes_Name",
                table: "LoadTypes",
                column: "Name",
                unique: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsEnabled",
                table: "LoadTypes",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddForeignKey(
                name: "FK_Drivers_Drivers_Commons_Bridge",
                table: "Drivers",
                column: "Bridge",
                principalTable: "Drivers_Commons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Drivers_Externals_Drivers_Commons_Bridge",
                table: "Drivers_Externals",
                column: "Bridge",
                principalTable: "Drivers_Commons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trailers_Trailers_Commons_Bridge",
                table: "Trailers",
                column: "Bridge",
                principalTable: "Trailers_Commons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trailers_Externals_Trailers_Commons_Bridge",
                table: "Trailers_Externals",
                column: "Bridge",
                principalTable: "Trailers_Commons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trucks_TrucksCommons_Bridge",
                table: "Trucks",
                column: "Bridge",
                principalTable: "TrucksCommons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trucks_Externals_TrucksCommons_Bridge",
                table: "Trucks_Externals",
                column: "Bridge",
                principalTable: "TrucksCommons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Drivers_Drivers_Commons_Bridge",
                table: "Drivers");

            migrationBuilder.DropForeignKey(
                name: "FK_Drivers_Externals_Drivers_Commons_Bridge",
                table: "Drivers_Externals");

            migrationBuilder.DropForeignKey(
                name: "FK_Trailers_Trailers_Commons_Bridge",
                table: "Trailers");

            migrationBuilder.DropForeignKey(
                name: "FK_Trailers_Externals_Trailers_Commons_Bridge",
                table: "Trailers_Externals");

            migrationBuilder.DropForeignKey(
                name: "FK_Trucks_TrucksCommons_Bridge",
                table: "Trucks");

            migrationBuilder.DropForeignKey(
                name: "FK_Trucks_Externals_TrucksCommons_Bridge",
                table: "Trucks_Externals");

            migrationBuilder.DropIndex(
                name: "IX_Yard_Logs_Guard",
                table: "Yard_Logs");

            migrationBuilder.DropIndex(
                name: "IX_Statuses_Name",
                table: "Statuses");

            migrationBuilder.DropIndex(
                name: "IX_Situations_Name",
                table: "Situations");

            migrationBuilder.DropIndex(
                name: "IX_LoadTypes_Name",
                table: "LoadTypes");

            migrationBuilder.DropColumn(
                name: "IsEnabled",
                table: "Statuses");

            migrationBuilder.DropColumn(
                name: "IsEnabled",
                table: "Situations");

            migrationBuilder.DropColumn(
                name: "IsEnabled",
                table: "LoadTypes");

            migrationBuilder.RenameColumn(
                name: "Bridge",
                table: "Trucks_Externals",
                newName: "Common");

            migrationBuilder.RenameIndex(
                name: "IX_Trucks_Externals_Bridge",
                table: "Trucks_Externals",
                newName: "IX_Trucks_Externals_Common");

            migrationBuilder.RenameColumn(
                name: "Bridge",
                table: "Trucks",
                newName: "Common");

            migrationBuilder.RenameIndex(
                name: "IX_Trucks_Bridge",
                table: "Trucks",
                newName: "IX_Trucks_Common");

            migrationBuilder.RenameColumn(
                name: "Bridge",
                table: "Trailers_Externals",
                newName: "Common");

            migrationBuilder.RenameIndex(
                name: "IX_Trailers_Externals_Bridge",
                table: "Trailers_Externals",
                newName: "IX_Trailers_Externals_Common");

            migrationBuilder.RenameColumn(
                name: "Bridge",
                table: "Trailers",
                newName: "Common");

            migrationBuilder.RenameIndex(
                name: "IX_Trailers_Bridge",
                table: "Trailers",
                newName: "IX_Trailers_Common");

            migrationBuilder.RenameColumn(
                name: "Bridge",
                table: "Drivers_Externals",
                newName: "Common");

            migrationBuilder.RenameIndex(
                name: "IX_Drivers_Externals_Bridge",
                table: "Drivers_Externals",
                newName: "IX_Drivers_Externals_Common");

            migrationBuilder.RenameColumn(
                name: "Bridge",
                table: "Drivers",
                newName: "Common");

            migrationBuilder.RenameIndex(
                name: "IX_Drivers_Bridge",
                table: "Drivers",
                newName: "IX_Drivers_Common");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Statuses",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                table: "Statuses",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(200)",
                oldMaxLength: 200,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Situations",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                table: "Situations",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(200)",
                oldMaxLength: 200,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "LoadTypes",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                table: "LoadTypes",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(200)",
                oldMaxLength: 200,
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Yard_Logs_Guard",
                table: "Yard_Logs",
                column: "Guard");

            migrationBuilder.AddForeignKey(
                name: "FK_Drivers_Drivers_Commons_Common",
                table: "Drivers",
                column: "Common",
                principalTable: "Drivers_Commons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Drivers_Externals_Drivers_Commons_Common",
                table: "Drivers_Externals",
                column: "Common",
                principalTable: "Drivers_Commons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trailers_Trailers_Commons_Common",
                table: "Trailers",
                column: "Common",
                principalTable: "Trailers_Commons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trailers_Externals_Trailers_Commons_Common",
                table: "Trailers_Externals",
                column: "Common",
                principalTable: "Trailers_Commons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trucks_TrucksCommons_Common",
                table: "Trucks",
                column: "Common",
                principalTable: "TrucksCommons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trucks_Externals_TrucksCommons_Common",
                table: "Trucks_Externals",
                column: "Common",
                principalTable: "TrucksCommons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
