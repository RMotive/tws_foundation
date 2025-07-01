using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CSM_Security.Migrations;

/// <inheritdoc />
public partial class _03172025Timestampprecissionchangefrom3to7nanosecondsdigits : Migration
{
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.DropForeignKey(
            name: "FK_Accounts_Contacts_Contact",
            table: "Accounts");

        migrationBuilder.DropForeignKey(
            name: "FK_Permits_Actions_Action",
            table: "Permits");

        migrationBuilder.DropForeignKey(
            name: "FK_Permits_Features_Feature",
            table: "Permits");

        migrationBuilder.DropForeignKey(
            name: "FK_Permits_Solutions_Solution",
            table: "Permits");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Solutions",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Profiles",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Permits",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Features",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Contacts",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Actions",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Accounts",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AddForeignKey(
            name: "FK_Accounts_Contacts_Contact",
            table: "Accounts",
            column: "Contact",
            principalTable: "Contacts",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_Permits_Actions_Action",
            table: "Permits",
            column: "Action",
            principalTable: "Actions",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Permits_Features_Feature",
            table: "Permits",
            column: "Feature",
            principalTable: "Features",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Permits_Solutions_Solution",
            table: "Permits",
            column: "Solution",
            principalTable: "Solutions",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.DropForeignKey(
            name: "FK_Accounts_Contacts_Contact",
            table: "Accounts");

        migrationBuilder.DropForeignKey(
            name: "FK_Permits_Actions_Action",
            table: "Permits");

        migrationBuilder.DropForeignKey(
            name: "FK_Permits_Features_Feature",
            table: "Permits");

        migrationBuilder.DropForeignKey(
            name: "FK_Permits_Solutions_Solution",
            table: "Permits");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Solutions",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Profiles",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Permits",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Features",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Contacts",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Actions",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Accounts",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AddForeignKey(
            name: "FK_Accounts_Contacts_Contact",
            table: "Accounts",
            column: "Contact",
            principalTable: "Contacts",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Permits_Actions_Action",
            table: "Permits",
            column: "Action",
            principalTable: "Actions",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Permits_Features_Feature",
            table: "Permits",
            column: "Feature",
            principalTable: "Features",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Permits_Solutions_Solution",
            table: "Permits",
            column: "Solution",
            principalTable: "Solutions",
            principalColumn: "Id");
    }
}
