using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CSM_Security.Migrations;
/// <inheritdoc />
public partial class _03022025Entitiesnormalization : Migration {
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder) {
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

        migrationBuilder.DropIndex(
            name: "IX_Permits_Action_Solution_Feature",
            table: "Permits");

        migrationBuilder.DropIndex(
            name: "IX_Contacts_Name",
            table: "Contacts");

        migrationBuilder.DropColumn(
            name: "Description",
            table: "Contacts");

        migrationBuilder.AlterColumn<string>(
            name: "Reference",
            table: "Permits",
            type: "nchar(8)",
            fixedLength: true,
            maxLength: 8,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "nvarchar(450)");

        migrationBuilder.AlterColumn<string>(
            name: "Name",
            table: "Features",
            type: "nvarchar(100)",
            maxLength: 100,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "nvarchar(25)",
            oldMaxLength: 25);

        migrationBuilder.AlterColumn<string>(
            name: "Phone",
            table: "Contacts",
            type: "nvarchar(14)",
            maxLength: 14,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "varchar(14)",
            oldUnicode: false,
            oldMaxLength: 14);

        migrationBuilder.AlterColumn<string>(
            name: "Name",
            table: "Contacts",
            type: "nvarchar(100)",
            maxLength: 100,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "varchar(50)",
            oldUnicode: false,
            oldMaxLength: 50);

        migrationBuilder.AlterColumn<string>(
            name: "Lastname",
            table: "Contacts",
            type: "nvarchar(100)",
            maxLength: 100,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "varchar(50)",
            oldUnicode: false,
            oldMaxLength: 50);

        migrationBuilder.AlterColumn<string>(
            name: "EMail",
            table: "Contacts",
            type: "nvarchar(100)",
            maxLength: 100,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "varchar(30)",
            oldUnicode: false,
            oldMaxLength: 30);

        migrationBuilder.CreateIndex(
            name: "IX_Permits_Action_Solution_Feature",
            table: "Permits",
            columns: ["Action", "Solution", "Feature"]);

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

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder) {
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

        migrationBuilder.DropIndex(
            name: "IX_Permits_Action_Solution_Feature",
            table: "Permits");

        migrationBuilder.AlterColumn<string>(
            name: "Reference",
            table: "Permits",
            type: "nvarchar(450)",
            nullable: false,
            oldClrType: typeof(string),
            oldType: "nchar(8)",
            oldFixedLength: true,
            oldMaxLength: 8);

        migrationBuilder.AlterColumn<string>(
            name: "Name",
            table: "Features",
            type: "nvarchar(25)",
            maxLength: 25,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "nvarchar(100)",
            oldMaxLength: 100);

        migrationBuilder.AlterColumn<string>(
            name: "Phone",
            table: "Contacts",
            type: "varchar(14)",
            unicode: false,
            maxLength: 14,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "nvarchar(14)",
            oldMaxLength: 14);

        migrationBuilder.AlterColumn<string>(
            name: "Name",
            table: "Contacts",
            type: "varchar(50)",
            unicode: false,
            maxLength: 50,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "nvarchar(100)",
            oldMaxLength: 100);

        migrationBuilder.AlterColumn<string>(
            name: "Lastname",
            table: "Contacts",
            type: "varchar(50)",
            unicode: false,
            maxLength: 50,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "nvarchar(100)",
            oldMaxLength: 100);

        migrationBuilder.AlterColumn<string>(
            name: "EMail",
            table: "Contacts",
            type: "varchar(30)",
            unicode: false,
            maxLength: 30,
            nullable: false,
            oldClrType: typeof(string),
            oldType: "nvarchar(100)",
            oldMaxLength: 100);

        migrationBuilder.AddColumn<string>(
            name: "Description",
            table: "Contacts",
            type: "nvarchar(200)",
            maxLength: 200,
            nullable: true);

        migrationBuilder.CreateIndex(
            name: "IX_Permits_Action_Solution_Feature",
            table: "Permits",
            columns: ["Action", "Solution", "Feature"],
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Contacts_Name",
            table: "Contacts",
            column: "Name",
            unique: true);

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
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_Permits_Features_Feature",
            table: "Permits",
            column: "Feature",
            principalTable: "Features",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_Permits_Solutions_Solution",
            table: "Permits",
            column: "Solution",
            principalTable: "Solutions",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);
    }
}
