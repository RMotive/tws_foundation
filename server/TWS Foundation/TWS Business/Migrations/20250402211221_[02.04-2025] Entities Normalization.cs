using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations;  
/// <inheritdoc />
public partial class _02042025EntitiesNormalization : Migration {
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder) {
        migrationBuilder.DropForeignKey(
            name: "FK_Approaches_Statuses_Status",
            table: "Approaches");

        migrationBuilder.DropForeignKey(
            name: "FK_Carriers_Addresses_Address",
            table: "Carriers");

        migrationBuilder.DropForeignKey(
            name: "FK_Carriers_Approaches_Approach",
            table: "Carriers");

        migrationBuilder.DropForeignKey(
            name: "FK_Carriers_Statuses_Status",
            table: "Carriers");

        migrationBuilder.DropForeignKey(
            name: "FK_Carriers_USDOTs_USDOT",
            table: "Carriers");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Drivers_Commons_Common",
            table: "Drivers");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Employees_Employee",
            table: "Drivers");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Commons_Situations_Situation",
            table: "Drivers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Commons_Statuses_Status",
            table: "Drivers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Externals_Drivers_Commons_Common",
            table: "Drivers_Externals");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Externals_Identifications_Identification",
            table: "Drivers_Externals");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Addresses_Address",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Approaches_Approach",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Employee_Dates_Dates",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Identifications_Identification",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Statuses_Status",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Identifications_Statuses_Status",
            table: "Identifications");

        migrationBuilder.DropForeignKey(
            name: "FK_Insurances_Statuses_Status",
            table: "Insurances");

        migrationBuilder.DropForeignKey(
            name: "FK_Locations_Addresses_Address",
            table: "Locations");

        migrationBuilder.DropForeignKey(
            name: "FK_Locations_Statuses_Status",
            table: "Locations");

        migrationBuilder.DropForeignKey(
            name: "FK_Maintenances_Statuses_Status",
            table: "Maintenances");

        migrationBuilder.DropForeignKey(
            name: "FK_Plates_Statuses_Status",
            table: "Plates");

        migrationBuilder.DropForeignKey(
            name: "FK_SCTs_Statuses_Status",
            table: "SCTs");

        migrationBuilder.DropForeignKey(
            name: "FK_Sections_Locations_Yard",
            table: "Sections");

        migrationBuilder.DropForeignKey(
            name: "FK_Sections_Statuses_Status",
            table: "Sections");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailer_Types_Statuses_Status",
            table: "Trailer_Types");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailer_Types_Trailer_Classes_Class",
            table: "Trailer_Types");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Carriers_Carrier",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Maintenances_Maintenance",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_SCTs_SCT",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Trailers_Commons_Common",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Vehicule_Models_Model",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Commons_Locations_Location",
            table: "Trailers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Commons_Situations_Situation",
            table: "Trailers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Commons_Statuses_Status",
            table: "Trailers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Commons_Trailer_Types_Type",
            table: "Trailers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Externals_Trailers_Commons_Common",
            table: "Trailers_Externals");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_Carriers_Carrier",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_Maintenances_Maintenance",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_SCTs_SCT",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_TrucksCommons_Common",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_Vehicule_Models_Model",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_Externals_TrucksCommons_Common",
            table: "Trucks_Externals");

        migrationBuilder.DropForeignKey(
            name: "FK_TrucksCommons_Locations_Location",
            table: "TrucksCommons");

        migrationBuilder.DropForeignKey(
            name: "FK_TrucksCommons_Situations_Situation",
            table: "TrucksCommons");

        migrationBuilder.DropForeignKey(
            name: "FK_TrucksCommons_Statuses_Status",
            table: "TrucksCommons");

        migrationBuilder.DropForeignKey(
            name: "FK_USDOTs_Statuses_Status",
            table: "USDOTs");

        migrationBuilder.DropForeignKey(
            name: "FK_Vehicule_Models_Manufacturers_Manufacturer",
            table: "Vehicule_Models");

        migrationBuilder.DropForeignKey(
            name: "FK_Vehicule_Models_Statuses_Status",
            table: "Vehicule_Models");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_Drivers_Commons_Driver",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_Employees_Guard",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_LoadTypes_LoadType",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_Sections_Section",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_Trailers_Commons_Trailer",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_TrucksCommons_Truck",
            table: "Yard_Logs");

        migrationBuilder.DropTable(
            name: "Inventory_Trucks");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Yard_Logs",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Vehicule_Models",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "USDOTs",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "TrucksCommons",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trucks_Externals",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trucks",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailers_Externals",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailers_Commons",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailers",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailer_Types",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailer_Classes",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Statuses",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Situations",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Sections",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "SCTs",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Plates",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Manufacturers",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Maintenances",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Locations",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "LoadTypes",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Insurances",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Identifications",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Employees",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Drivers_Externals",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Drivers_Commons",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Drivers",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Carriers",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Approaches",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Addresses",
            type: "datetime2(7)",
            nullable: false,
            defaultValueSql: "GETUTCDATE()",
            oldClrType: typeof(DateTime),
            oldType: "datetime");

        migrationBuilder.AddForeignKey(
            name: "FK_Approaches_Statuses_Status",
            table: "Approaches",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Carriers_Addresses_Address",
            table: "Carriers",
            column: "Address",
            principalTable: "Addresses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Carriers_Approaches_Approach",
            table: "Carriers",
            column: "Approach",
            principalTable: "Approaches",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Carriers_Statuses_Status",
            table: "Carriers",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Carriers_USDOTs_USDOT",
            table: "Carriers",
            column: "USDOT",
            principalTable: "USDOTs",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Drivers_Commons_Common",
            table: "Drivers",
            column: "Common",
            principalTable: "Drivers_Commons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Employees_Employee",
            table: "Drivers",
            column: "Employee",
            principalTable: "Employees",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Commons_Situations_Situation",
            table: "Drivers_Commons",
            column: "Situation",
            principalTable: "Situations",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Commons_Statuses_Status",
            table: "Drivers_Commons",
            column: "Status",
            principalTable: "Statuses",
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
            name: "FK_Drivers_Externals_Identifications_Identification",
            table: "Drivers_Externals",
            column: "Identification",
            principalTable: "Identifications",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Addresses_Address",
            table: "Employees",
            column: "Address",
            principalTable: "Addresses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Approaches_Approach",
            table: "Employees",
            column: "Approach",
            principalTable: "Approaches",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Employee_Dates_Dates",
            table: "Employees",
            column: "Dates",
            principalTable: "Employee_Dates",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Identifications_Identification",
            table: "Employees",
            column: "Identification",
            principalTable: "Identifications",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Statuses_Status",
            table: "Employees",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Identifications_Statuses_Status",
            table: "Identifications",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Insurances_Statuses_Status",
            table: "Insurances",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Locations_Addresses_Address",
            table: "Locations",
            column: "Address",
            principalTable: "Addresses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Locations_Statuses_Status",
            table: "Locations",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Maintenances_Statuses_Status",
            table: "Maintenances",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Plates_Statuses_Status",
            table: "Plates",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_SCTs_Statuses_Status",
            table: "SCTs",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Sections_Locations_Yard",
            table: "Sections",
            column: "Yard",
            principalTable: "Locations",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Sections_Statuses_Status",
            table: "Sections",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailer_Types_Statuses_Status",
            table: "Trailer_Types",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailer_Types_Trailer_Classes_Class",
            table: "Trailer_Types",
            column: "Class",
            principalTable: "Trailer_Classes",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Carriers_Carrier",
            table: "Trailers",
            column: "Carrier",
            principalTable: "Carriers",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Maintenances_Maintenance",
            table: "Trailers",
            column: "Maintenance",
            principalTable: "Maintenances",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_SCTs_SCT",
            table: "Trailers",
            column: "SCT",
            principalTable: "SCTs",
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
            name: "FK_Trailers_Vehicule_Models_Model",
            table: "Trailers",
            column: "Model",
            principalTable: "Vehicule_Models",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Commons_Locations_Location",
            table: "Trailers_Commons",
            column: "Location",
            principalTable: "Locations",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Commons_Situations_Situation",
            table: "Trailers_Commons",
            column: "Situation",
            principalTable: "Situations",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Commons_Statuses_Status",
            table: "Trailers_Commons",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Commons_Trailer_Types_Type",
            table: "Trailers_Commons",
            column: "Type",
            principalTable: "Trailer_Types",
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
            name: "FK_Trucks_Carriers_Carrier",
            table: "Trucks",
            column: "Carrier",
            principalTable: "Carriers",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_Maintenances_Maintenance",
            table: "Trucks",
            column: "Maintenance",
            principalTable: "Maintenances",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_SCTs_SCT",
            table: "Trucks",
            column: "SCT",
            principalTable: "SCTs",
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
            name: "FK_Trucks_Vehicule_Models_Model",
            table: "Trucks",
            column: "Model",
            principalTable: "Vehicule_Models",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_Externals_TrucksCommons_Common",
            table: "Trucks_Externals",
            column: "Common",
            principalTable: "TrucksCommons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_TrucksCommons_Locations_Location",
            table: "TrucksCommons",
            column: "Location",
            principalTable: "Locations",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_TrucksCommons_Situations_Situation",
            table: "TrucksCommons",
            column: "Situation",
            principalTable: "Situations",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_TrucksCommons_Statuses_Status",
            table: "TrucksCommons",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_USDOTs_Statuses_Status",
            table: "USDOTs",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Vehicule_Models_Manufacturers_Manufacturer",
            table: "Vehicule_Models",
            column: "Manufacturer",
            principalTable: "Manufacturers",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Vehicule_Models_Statuses_Status",
            table: "Vehicule_Models",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_Drivers_Commons_Driver",
            table: "Yard_Logs",
            column: "Driver",
            principalTable: "Drivers_Commons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_Employees_Guard",
            table: "Yard_Logs",
            column: "Guard",
            principalTable: "Employees",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_LoadTypes_LoadType",
            table: "Yard_Logs",
            column: "LoadType",
            principalTable: "LoadTypes",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_Sections_Section",
            table: "Yard_Logs",
            column: "Section",
            principalTable: "Sections",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_Trailers_Commons_Trailer",
            table: "Yard_Logs",
            column: "Trailer",
            principalTable: "Trailers_Commons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_TrucksCommons_Truck",
            table: "Yard_Logs",
            column: "Truck",
            principalTable: "TrucksCommons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict);
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder) {
        migrationBuilder.DropForeignKey(
            name: "FK_Approaches_Statuses_Status",
            table: "Approaches");

        migrationBuilder.DropForeignKey(
            name: "FK_Carriers_Addresses_Address",
            table: "Carriers");

        migrationBuilder.DropForeignKey(
            name: "FK_Carriers_Approaches_Approach",
            table: "Carriers");

        migrationBuilder.DropForeignKey(
            name: "FK_Carriers_Statuses_Status",
            table: "Carriers");

        migrationBuilder.DropForeignKey(
            name: "FK_Carriers_USDOTs_USDOT",
            table: "Carriers");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Drivers_Commons_Common",
            table: "Drivers");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Employees_Employee",
            table: "Drivers");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Commons_Situations_Situation",
            table: "Drivers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Commons_Statuses_Status",
            table: "Drivers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Externals_Drivers_Commons_Common",
            table: "Drivers_Externals");

        migrationBuilder.DropForeignKey(
            name: "FK_Drivers_Externals_Identifications_Identification",
            table: "Drivers_Externals");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Addresses_Address",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Approaches_Approach",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Employee_Dates_Dates",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Identifications_Identification",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Employees_Statuses_Status",
            table: "Employees");

        migrationBuilder.DropForeignKey(
            name: "FK_Identifications_Statuses_Status",
            table: "Identifications");

        migrationBuilder.DropForeignKey(
            name: "FK_Insurances_Statuses_Status",
            table: "Insurances");

        migrationBuilder.DropForeignKey(
            name: "FK_Locations_Addresses_Address",
            table: "Locations");

        migrationBuilder.DropForeignKey(
            name: "FK_Locations_Statuses_Status",
            table: "Locations");

        migrationBuilder.DropForeignKey(
            name: "FK_Maintenances_Statuses_Status",
            table: "Maintenances");

        migrationBuilder.DropForeignKey(
            name: "FK_Plates_Statuses_Status",
            table: "Plates");

        migrationBuilder.DropForeignKey(
            name: "FK_SCTs_Statuses_Status",
            table: "SCTs");

        migrationBuilder.DropForeignKey(
            name: "FK_Sections_Locations_Yard",
            table: "Sections");

        migrationBuilder.DropForeignKey(
            name: "FK_Sections_Statuses_Status",
            table: "Sections");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailer_Types_Statuses_Status",
            table: "Trailer_Types");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailer_Types_Trailer_Classes_Class",
            table: "Trailer_Types");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Carriers_Carrier",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Maintenances_Maintenance",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_SCTs_SCT",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Trailers_Commons_Common",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Vehicule_Models_Model",
            table: "Trailers");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Commons_Locations_Location",
            table: "Trailers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Commons_Situations_Situation",
            table: "Trailers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Commons_Statuses_Status",
            table: "Trailers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Commons_Trailer_Types_Type",
            table: "Trailers_Commons");

        migrationBuilder.DropForeignKey(
            name: "FK_Trailers_Externals_Trailers_Commons_Common",
            table: "Trailers_Externals");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_Carriers_Carrier",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_Maintenances_Maintenance",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_SCTs_SCT",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_TrucksCommons_Common",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_Vehicule_Models_Model",
            table: "Trucks");

        migrationBuilder.DropForeignKey(
            name: "FK_Trucks_Externals_TrucksCommons_Common",
            table: "Trucks_Externals");

        migrationBuilder.DropForeignKey(
            name: "FK_TrucksCommons_Locations_Location",
            table: "TrucksCommons");

        migrationBuilder.DropForeignKey(
            name: "FK_TrucksCommons_Situations_Situation",
            table: "TrucksCommons");

        migrationBuilder.DropForeignKey(
            name: "FK_TrucksCommons_Statuses_Status",
            table: "TrucksCommons");

        migrationBuilder.DropForeignKey(
            name: "FK_USDOTs_Statuses_Status",
            table: "USDOTs");

        migrationBuilder.DropForeignKey(
            name: "FK_Vehicule_Models_Manufacturers_Manufacturer",
            table: "Vehicule_Models");

        migrationBuilder.DropForeignKey(
            name: "FK_Vehicule_Models_Statuses_Status",
            table: "Vehicule_Models");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_Drivers_Commons_Driver",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_Employees_Guard",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_LoadTypes_LoadType",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_Sections_Section",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_Trailers_Commons_Trailer",
            table: "Yard_Logs");

        migrationBuilder.DropForeignKey(
            name: "FK_Yard_Logs_TrucksCommons_Truck",
            table: "Yard_Logs");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Yard_Logs",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Vehicule_Models",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "USDOTs",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "TrucksCommons",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trucks_Externals",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trucks",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailers_Externals",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailers_Commons",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailers",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailer_Types",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Trailer_Classes",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Statuses",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Situations",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Sections",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "SCTs",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Plates",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Manufacturers",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Maintenances",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Locations",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "LoadTypes",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Insurances",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Identifications",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Employees",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Drivers_Externals",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Drivers_Commons",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Drivers",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Carriers",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Approaches",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.AlterColumn<DateTime>(
            name: "Timestamp",
            table: "Addresses",
            type: "datetime",
            nullable: false,
            oldClrType: typeof(DateTime),
            oldType: "datetime2(7)",
            oldDefaultValueSql: "GETUTCDATE()");

        migrationBuilder.CreateTable(
            name: "Inventory_Trucks",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Section = table.Column<long>(type: "bigint", nullable: false),
                Truck = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Inventory_Trucks", x => x.Id);
                table.ForeignKey(
                    name: "FK_Inventory_Trucks_Sections_Section",
                    column: x => x.Section,
                    principalTable: "Sections",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Inventory_Trucks_TrucksCommons_Truck",
                    column: x => x.Truck,
                    principalTable: "TrucksCommons",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateIndex(
            name: "IX_Inventory_Trucks_Section",
            table: "Inventory_Trucks",
            column: "Section");

        migrationBuilder.CreateIndex(
            name: "IX_Inventory_Trucks_Truck",
            table: "Inventory_Trucks",
            column: "Truck");

        migrationBuilder.AddForeignKey(
            name: "FK_Approaches_Statuses_Status",
            table: "Approaches",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Carriers_Addresses_Address",
            table: "Carriers",
            column: "Address",
            principalTable: "Addresses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Carriers_Approaches_Approach",
            table: "Carriers",
            column: "Approach",
            principalTable: "Approaches",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Carriers_Statuses_Status",
            table: "Carriers",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Carriers_USDOTs_USDOT",
            table: "Carriers",
            column: "USDOT",
            principalTable: "USDOTs",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Drivers_Commons_Common",
            table: "Drivers",
            column: "Common",
            principalTable: "Drivers_Commons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Employees_Employee",
            table: "Drivers",
            column: "Employee",
            principalTable: "Employees",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Commons_Situations_Situation",
            table: "Drivers_Commons",
            column: "Situation",
            principalTable: "Situations",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Commons_Statuses_Status",
            table: "Drivers_Commons",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Externals_Drivers_Commons_Common",
            table: "Drivers_Externals",
            column: "Common",
            principalTable: "Drivers_Commons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_Drivers_Externals_Identifications_Identification",
            table: "Drivers_Externals",
            column: "Identification",
            principalTable: "Identifications",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Addresses_Address",
            table: "Employees",
            column: "Address",
            principalTable: "Addresses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Approaches_Approach",
            table: "Employees",
            column: "Approach",
            principalTable: "Approaches",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Employee_Dates_Dates",
            table: "Employees",
            column: "Dates",
            principalTable: "Employee_Dates",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Identifications_Identification",
            table: "Employees",
            column: "Identification",
            principalTable: "Identifications",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Employees_Statuses_Status",
            table: "Employees",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Identifications_Statuses_Status",
            table: "Identifications",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Insurances_Statuses_Status",
            table: "Insurances",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Locations_Addresses_Address",
            table: "Locations",
            column: "Address",
            principalTable: "Addresses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Locations_Statuses_Status",
            table: "Locations",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Maintenances_Statuses_Status",
            table: "Maintenances",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Plates_Statuses_Status",
            table: "Plates",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_SCTs_Statuses_Status",
            table: "SCTs",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Sections_Locations_Yard",
            table: "Sections",
            column: "Yard",
            principalTable: "Locations",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Sections_Statuses_Status",
            table: "Sections",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailer_Types_Statuses_Status",
            table: "Trailer_Types",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailer_Types_Trailer_Classes_Class",
            table: "Trailer_Types",
            column: "Class",
            principalTable: "Trailer_Classes",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Carriers_Carrier",
            table: "Trailers",
            column: "Carrier",
            principalTable: "Carriers",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Maintenances_Maintenance",
            table: "Trailers",
            column: "Maintenance",
            principalTable: "Maintenances",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_SCTs_SCT",
            table: "Trailers",
            column: "SCT",
            principalTable: "SCTs",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Trailers_Commons_Common",
            table: "Trailers",
            column: "Common",
            principalTable: "Trailers_Commons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Vehicule_Models_Model",
            table: "Trailers",
            column: "Model",
            principalTable: "Vehicule_Models",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Commons_Locations_Location",
            table: "Trailers_Commons",
            column: "Location",
            principalTable: "Locations",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Commons_Situations_Situation",
            table: "Trailers_Commons",
            column: "Situation",
            principalTable: "Situations",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Commons_Statuses_Status",
            table: "Trailers_Commons",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Commons_Trailer_Types_Type",
            table: "Trailers_Commons",
            column: "Type",
            principalTable: "Trailer_Types",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trailers_Externals_Trailers_Commons_Common",
            table: "Trailers_Externals",
            column: "Common",
            principalTable: "Trailers_Commons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_Carriers_Carrier",
            table: "Trucks",
            column: "Carrier",
            principalTable: "Carriers",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_Maintenances_Maintenance",
            table: "Trucks",
            column: "Maintenance",
            principalTable: "Maintenances",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_SCTs_SCT",
            table: "Trucks",
            column: "SCT",
            principalTable: "SCTs",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_TrucksCommons_Common",
            table: "Trucks",
            column: "Common",
            principalTable: "TrucksCommons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_Vehicule_Models_Model",
            table: "Trucks",
            column: "Model",
            principalTable: "Vehicule_Models",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Trucks_Externals_TrucksCommons_Common",
            table: "Trucks_Externals",
            column: "Common",
            principalTable: "TrucksCommons",
            principalColumn: "Id",
            onDelete: ReferentialAction.Cascade);

        migrationBuilder.AddForeignKey(
            name: "FK_TrucksCommons_Locations_Location",
            table: "TrucksCommons",
            column: "Location",
            principalTable: "Locations",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_TrucksCommons_Situations_Situation",
            table: "TrucksCommons",
            column: "Situation",
            principalTable: "Situations",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_TrucksCommons_Statuses_Status",
            table: "TrucksCommons",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_USDOTs_Statuses_Status",
            table: "USDOTs",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Vehicule_Models_Manufacturers_Manufacturer",
            table: "Vehicule_Models",
            column: "Manufacturer",
            principalTable: "Manufacturers",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Vehicule_Models_Statuses_Status",
            table: "Vehicule_Models",
            column: "Status",
            principalTable: "Statuses",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_Drivers_Commons_Driver",
            table: "Yard_Logs",
            column: "Driver",
            principalTable: "Drivers_Commons",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_Employees_Guard",
            table: "Yard_Logs",
            column: "Guard",
            principalTable: "Employees",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_LoadTypes_LoadType",
            table: "Yard_Logs",
            column: "LoadType",
            principalTable: "LoadTypes",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_Sections_Section",
            table: "Yard_Logs",
            column: "Section",
            principalTable: "Sections",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_Trailers_Commons_Trailer",
            table: "Yard_Logs",
            column: "Trailer",
            principalTable: "Trailers_Commons",
            principalColumn: "Id");

        migrationBuilder.AddForeignKey(
            name: "FK_Yard_Logs_TrucksCommons_Truck",
            table: "Yard_Logs",
            column: "Truck",
            principalTable: "TrucksCommons",
            principalColumn: "Id");
    }
}
