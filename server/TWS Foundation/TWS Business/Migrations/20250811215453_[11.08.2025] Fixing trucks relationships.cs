using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations
{
    /// <inheritdoc />
    public partial class _11082025Fixingtrucksrelationships : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Plates_Trailers_TrailerId",
                table: "Plates");

            migrationBuilder.DropForeignKey(
                name: "FK_Plates_Trucks_TruckId",
                table: "Plates");

            migrationBuilder.DropForeignKey(
                name: "FK_Trucks_Insurances_InsuranceId",
                table: "Trucks");

            migrationBuilder.DropIndex(
                name: "IX_Statuses_Name",
                table: "Statuses");

            migrationBuilder.DropIndex(
                name: "IX_Situations_Name",
                table: "Situations");

            migrationBuilder.RenameColumn(
                name: "InsuranceId",
                table: "Trucks",
                newName: "Insurance");

            migrationBuilder.RenameIndex(
                name: "IX_Trucks_InsuranceId",
                table: "Trucks",
                newName: "IX_Trucks_Insurance");

            migrationBuilder.RenameColumn(
                name: "TruckId",
                table: "Plates",
                newName: "Truck");

            migrationBuilder.RenameColumn(
                name: "TrailerId",
                table: "Plates",
                newName: "Trailer");

            migrationBuilder.RenameIndex(
                name: "IX_Plates_TruckId",
                table: "Plates",
                newName: "IX_Plates_Truck");

            migrationBuilder.RenameIndex(
                name: "IX_Plates_TrailerId",
                table: "Plates",
                newName: "IX_Plates_Trailer");

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

            migrationBuilder.AddForeignKey(
                name: "FK_Plates_Trailers_Trailer",
                table: "Plates",
                column: "Trailer",
                principalTable: "Trailers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Plates_Trucks_Truck",
                table: "Plates",
                column: "Truck",
                principalTable: "Trucks",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Trucks_Insurances_Insurance",
                table: "Trucks",
                column: "Insurance",
                principalTable: "Insurances",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Plates_Trailers_Trailer",
                table: "Plates");

            migrationBuilder.DropForeignKey(
                name: "FK_Plates_Trucks_Truck",
                table: "Plates");

            migrationBuilder.DropForeignKey(
                name: "FK_Trucks_Insurances_Insurance",
                table: "Trucks");

            migrationBuilder.RenameColumn(
                name: "Insurance",
                table: "Trucks",
                newName: "InsuranceId");

            migrationBuilder.RenameIndex(
                name: "IX_Trucks_Insurance",
                table: "Trucks",
                newName: "IX_Trucks_InsuranceId");

            migrationBuilder.RenameColumn(
                name: "Truck",
                table: "Plates",
                newName: "TruckId");

            migrationBuilder.RenameColumn(
                name: "Trailer",
                table: "Plates",
                newName: "TrailerId");

            migrationBuilder.RenameIndex(
                name: "IX_Plates_Truck",
                table: "Plates",
                newName: "IX_Plates_TruckId");

            migrationBuilder.RenameIndex(
                name: "IX_Plates_Trailer",
                table: "Plates",
                newName: "IX_Plates_TrailerId");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Statuses",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                table: "Statuses",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Situations",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                table: "Situations",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "LoadTypes",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

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
                name: "IX_Statuses_Name",
                table: "Statuses",
                column: "Name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Situations_Name",
                table: "Situations",
                column: "Name",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Plates_Trailers_TrailerId",
                table: "Plates",
                column: "TrailerId",
                principalTable: "Trailers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Plates_Trucks_TruckId",
                table: "Plates",
                column: "TruckId",
                principalTable: "Trucks",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Trucks_Insurances_InsuranceId",
                table: "Trucks",
                column: "InsuranceId",
                principalTable: "Insurances",
                principalColumn: "Id");
        }
    }
}
