using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CSM_Security.Migrations; 
/// <inheritdoc />
public partial class _03262025AddeddefaulttimestampvalueasGETUTCDATEgatheredfromsqlinstancetimemanagement : Migration {
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder) {
        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Solutions",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Profiles",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Permits",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Features",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Contacts",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Actions",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Accounts",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)");
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder) {
        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Solutions",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Profiles",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Permits",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Features",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Contacts",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Actions",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Accounts",
            type: "datetime2(7)",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");
    }
}
