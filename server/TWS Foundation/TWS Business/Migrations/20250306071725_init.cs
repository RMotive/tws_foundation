using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TWS_Business.Migrations;

/// <inheritdoc />
#pragma warning disable CS8981 // The type name only contains lower-cased ascii characters. Such names may become reserved for the language.
public partial class init : Migration {
#pragma warning restore CS8981 // The type name only contains lower-cased ascii characters. Such names may become reserved for the language.
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder) {
        migrationBuilder.CreateTable(
            name: "Addresses",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                State = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: true),
                Street = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                AltStreet = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                City = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                ZIP = table.Column<string>(type: "nchar(5)", fixedLength: true, maxLength: 5, nullable: true),
                Country = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: false),
                Subdivision = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Addresses", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Employee_Dates",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                CNAP = table.Column<DateOnly>(type: "date", nullable: true),
                IMSS = table.Column<DateOnly>(type: "date", nullable: true),
                Hire = table.Column<DateOnly>(type: "date", nullable: true),
                Termination = table.Column<DateOnly>(type: "date", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Employee_Dates", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "LoadTypes",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_LoadTypes", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Manufacturers",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Manufacturers", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Situations",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Situations", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Statuses",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Statuses", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Trailer_Classes",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Trailer_Classes", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Approaches",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                EMail = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false),
                Enterprise = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: true),
                Personal = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: true),
                Alternative = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Approaches", x => x.Id);
                table.ForeignKey(
                    name: "FK_Approaches_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Drivers_Commons",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                License = table.Column<string>(type: "nvarchar(12)", maxLength: 12, nullable: false),
                Situation = table.Column<long>(type: "bigint", nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Drivers_Commons", x => x.Id);
                table.ForeignKey(
                    name: "FK_Drivers_Commons_Situations_Situation",
                    column: x => x.Situation,
                    principalTable: "Situations",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Drivers_Commons_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Identifications",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(32)", maxLength: 32, nullable: false),
                Lastname = table.Column<string>(type: "nvarchar(32)", maxLength: 32, nullable: false),
                Birthday = table.Column<DateOnly>(type: "date", nullable: true),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Identifications", x => x.Id);
                table.ForeignKey(
                    name: "FK_Identifications_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Insurances",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Policy = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                Country = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: false),
                Expiration = table.Column<DateOnly>(type: "date", nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Insurances", x => x.Id);
                table.ForeignKey(
                    name: "FK_Insurances_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Locations",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Address = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Locations", x => x.Id);
                table.ForeignKey(
                    name: "FK_Locations_Addresses_Address",
                    column: x => x.Address,
                    principalTable: "Addresses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Locations_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Maintenances",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Anual = table.Column<DateOnly>(type: "date", nullable: false),
                Trimestral = table.Column<DateOnly>(type: "date", nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Maintenances", x => x.Id);
                table.ForeignKey(
                    name: "FK_Maintenances_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "SCTs",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Type = table.Column<string>(type: "nvarchar(6)", maxLength: 6, nullable: false),
                Number = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                Configuration = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_SCTs", x => x.Id);
                table.ForeignKey(
                    name: "FK_SCTs_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "USDOTs",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                MC = table.Column<string>(type: "nchar(7)", fixedLength: true, maxLength: 7, nullable: false),
                SCAC = table.Column<string>(type: "nchar(4)", fixedLength: true, maxLength: 4, nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_USDOTs", x => x.Id);
                table.ForeignKey(
                    name: "FK_USDOTs_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Vehicule_Models",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Year = table.Column<DateOnly>(type: "date", nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Manufacturer = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Vehicule_Models", x => x.Id);
                table.ForeignKey(
                    name: "FK_Vehicule_Models_Manufacturers_Manufacturer",
                    column: x => x.Manufacturer,
                    principalTable: "Manufacturers",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Vehicule_Models_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Trailer_Types",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Size = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Class = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Trailer_Types", x => x.Id);
                table.ForeignKey(
                    name: "FK_Trailer_Types_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trailer_Types_Trailer_Classes_Class",
                    column: x => x.Class,
                    principalTable: "Trailer_Classes",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Approach_History",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                EMail = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: true),
                Enterprise = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: true),
                Personal = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: true),
                Alternative = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: true),
                ApproachId = table.Column<long>(type: "bigint", nullable: true),
                StatusId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                Sequence = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Approach_History", x => x.Id);
                table.ForeignKey(
                    name: "FK_Approach_History_Approaches_ApproachId",
                    column: x => x.ApproachId,
                    principalTable: "Approaches",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Approach_History_Statuses_StatusId",
                    column: x => x.StatusId,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Drivers_Externals",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Identification = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false),
                Common = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Drivers_Externals", x => x.Id);
                table.ForeignKey(
                    name: "FK_Drivers_Externals_Drivers_Commons_Common",
                    column: x => x.Common,
                    principalTable: "Drivers_Commons",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Drivers_Externals_Identifications_Identification",
                    column: x => x.Identification,
                    principalTable: "Identifications",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Employees",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                CURP = table.Column<string>(type: "nvarchar(18)", maxLength: 18, nullable: true),
                RFC = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: true),
                NSS = table.Column<string>(type: "nvarchar(11)", maxLength: 11, nullable: true),
                Identification = table.Column<long>(type: "bigint", nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Dates = table.Column<long>(type: "bigint", nullable: false),
                Approach = table.Column<long>(type: "bigint", nullable: true),
                Address = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Employees", x => x.Id);
                table.ForeignKey(
                    name: "FK_Employees_Addresses_Address",
                    column: x => x.Address,
                    principalTable: "Addresses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Employees_Approaches_Approach",
                    column: x => x.Approach,
                    principalTable: "Approaches",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Employees_Employee_Dates_Dates",
                    column: x => x.Dates,
                    principalTable: "Employee_Dates",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Employees_Identifications_Identification",
                    column: x => x.Identification,
                    principalTable: "Identifications",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Employees_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Insurance_History",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Policy = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                Country = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: false),
                Expiration = table.Column<DateOnly>(type: "date", nullable: false),
                InsuranceId = table.Column<long>(type: "bigint", nullable: true),
                StatusId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                Sequence = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Insurance_History", x => x.Id);
                table.ForeignKey(
                    name: "FK_Insurance_History_Insurances_InsuranceId",
                    column: x => x.InsuranceId,
                    principalTable: "Insurances",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Insurance_History_Statuses_StatusId",
                    column: x => x.StatusId,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Sections",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Capacity = table.Column<int>(type: "int", nullable: false),
                Ocupancy = table.Column<int>(type: "int", nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Yard = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Sections", x => x.Id);
                table.ForeignKey(
                    name: "FK_Sections_Locations_Yard",
                    column: x => x.Yard,
                    principalTable: "Locations",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Sections_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "TrucksCommons",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Economic = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: false),
                Location = table.Column<long>(type: "bigint", nullable: true),
                Situation = table.Column<long>(type: "bigint", nullable: true),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_TrucksCommons", x => x.Id);
                table.ForeignKey(
                    name: "FK_TrucksCommons_Locations_Location",
                    column: x => x.Location,
                    principalTable: "Locations",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_TrucksCommons_Situations_Situation",
                    column: x => x.Situation,
                    principalTable: "Situations",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_TrucksCommons_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Maintenance_History",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Anual = table.Column<DateTime>(type: "datetime2", nullable: false),
                Trimestral = table.Column<DateTime>(type: "datetime2", nullable: false),
                MaintenanceId = table.Column<long>(type: "bigint", nullable: true),
                StatusId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                Sequence = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Maintenance_History", x => x.Id);
                table.ForeignKey(
                    name: "FK_Maintenance_History_Maintenances_MaintenanceId",
                    column: x => x.MaintenanceId,
                    principalTable: "Maintenances",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Maintenance_History_Statuses_StatusId",
                    column: x => x.StatusId,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "SCT_History",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Type = table.Column<string>(type: "nvarchar(6)", maxLength: 6, nullable: false),
                Number = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                Configuration = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                SCTId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                Sequence = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_SCT_History", x => x.Id);
                table.ForeignKey(
                    name: "FK_SCT_History_SCTs_SCTId",
                    column: x => x.SCTId,
                    principalTable: "SCTs",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Carriers",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Approach = table.Column<long>(type: "bigint", nullable: false),
                Address = table.Column<long>(type: "bigint", nullable: false),
                USDOT = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Carriers", x => x.Id);
                table.ForeignKey(
                    name: "FK_Carriers_Addresses_Address",
                    column: x => x.Address,
                    principalTable: "Addresses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Carriers_Approaches_Approach",
                    column: x => x.Approach,
                    principalTable: "Approaches",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Carriers_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Carriers_USDOTs_USDOT",
                    column: x => x.USDOT,
                    principalTable: "USDOTs",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "USDOT_History",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                MC = table.Column<string>(type: "nvarchar(7)", maxLength: 7, nullable: false),
                SCAC = table.Column<string>(type: "nvarchar(4)", maxLength: 4, nullable: false),
                USDOTId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                Sequence = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_USDOT_History", x => x.Id);
                table.ForeignKey(
                    name: "FK_USDOT_History_USDOTs_USDOTId",
                    column: x => x.USDOTId,
                    principalTable: "USDOTs",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Trailers_Commons",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Economic = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: false),
                Status = table.Column<long>(type: "bigint", nullable: false),
                Type = table.Column<long>(type: "bigint", nullable: true),
                Situation = table.Column<long>(type: "bigint", nullable: true),
                Location = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Trailers_Commons", x => x.Id);
                table.ForeignKey(
                    name: "FK_Trailers_Commons_Locations_Location",
                    column: x => x.Location,
                    principalTable: "Locations",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trailers_Commons_Situations_Situation",
                    column: x => x.Situation,
                    principalTable: "Situations",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trailers_Commons_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trailers_Commons_Trailer_Types_Type",
                    column: x => x.Type,
                    principalTable: "Trailer_Types",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Drivers",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Fast = table.Column<string>(type: "nvarchar(12)", maxLength: 12, nullable: true),
                ANAM = table.Column<string>(type: "nvarchar(24)", maxLength: 24, nullable: true),
                VISA = table.Column<string>(type: "nvarchar(12)", maxLength: 12, nullable: true),
                TWIC = table.Column<string>(type: "nvarchar(12)", maxLength: 12, nullable: true),
                DriverType = table.Column<string>(type: "nvarchar(12)", maxLength: 12, nullable: true),
                LicenseExpiration = table.Column<DateOnly>(type: "date", nullable: true),
                DrugalcRegistrationDate = table.Column<DateOnly>(type: "date", nullable: true),
                PullnoticeRegistrationDate = table.Column<DateOnly>(type: "date", nullable: true),
                TwicExpiration = table.Column<DateOnly>(type: "date", nullable: true),
                VisaExpiration = table.Column<DateOnly>(type: "date", nullable: true),
                FastExpiration = table.Column<DateOnly>(type: "date", nullable: true),
                AnamExpiration = table.Column<DateOnly>(type: "date", nullable: true),
                Employee = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false),
                Common = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Drivers", x => x.Id);
                table.ForeignKey(
                    name: "FK_Drivers_Drivers_Commons_Common",
                    column: x => x.Common,
                    principalTable: "Drivers_Commons",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Drivers_Employees_Employee",
                    column: x => x.Employee,
                    principalTable: "Employees",
                    principalColumn: "Id");
            });

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

        migrationBuilder.CreateTable(
            name: "Trucks_Externals",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Carrier = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                VIN = table.Column<string>(type: "nvarchar(17)", maxLength: 17, nullable: true),
                UsaPlate = table.Column<string>(type: "nvarchar(7)", maxLength: 7, nullable: true),
                MxPlate = table.Column<string>(type: "nvarchar(7)", maxLength: 7, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false),
                Common = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Trucks_Externals", x => x.Id);
                table.ForeignKey(
                    name: "FK_Trucks_Externals_TrucksCommons_Common",
                    column: x => x.Common,
                    principalTable: "TrucksCommons",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateTable(
            name: "Trucks",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Motor = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: true),
                VIN = table.Column<string>(type: "nvarchar(17)", maxLength: 17, nullable: false),
                Carrier = table.Column<long>(type: "bigint", nullable: false),
                Model = table.Column<long>(type: "bigint", nullable: false),
                SCT = table.Column<long>(type: "bigint", nullable: true),
                Maintenance = table.Column<long>(type: "bigint", nullable: true),
                InsuranceId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false),
                Common = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Trucks", x => x.Id);
                table.ForeignKey(
                    name: "FK_Trucks_Carriers_Carrier",
                    column: x => x.Carrier,
                    principalTable: "Carriers",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trucks_Insurances_InsuranceId",
                    column: x => x.InsuranceId,
                    principalTable: "Insurances",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trucks_Maintenances_Maintenance",
                    column: x => x.Maintenance,
                    principalTable: "Maintenances",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trucks_SCTs_SCT",
                    column: x => x.SCT,
                    principalTable: "SCTs",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trucks_TrucksCommons_Common",
                    column: x => x.Common,
                    principalTable: "TrucksCommons",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Trucks_Vehicule_Models_Model",
                    column: x => x.Model,
                    principalTable: "Vehicule_Models",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Carrier_History",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                AddressId = table.Column<long>(type: "bigint", nullable: true),
                Approach_HistoryId = table.Column<long>(type: "bigint", nullable: true),
                CarrierId = table.Column<long>(type: "bigint", nullable: true),
                SCT_HistoryId = table.Column<long>(type: "bigint", nullable: true),
                StatusId = table.Column<long>(type: "bigint", nullable: true),
                USDOT_HistoryId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                Sequence = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Carrier_History", x => x.Id);
                table.ForeignKey(
                    name: "FK_Carrier_History_Addresses_AddressId",
                    column: x => x.AddressId,
                    principalTable: "Addresses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Carrier_History_Approach_History_Approach_HistoryId",
                    column: x => x.Approach_HistoryId,
                    principalTable: "Approach_History",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Carrier_History_Carriers_CarrierId",
                    column: x => x.CarrierId,
                    principalTable: "Carriers",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Carrier_History_SCT_History_SCT_HistoryId",
                    column: x => x.SCT_HistoryId,
                    principalTable: "SCT_History",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Carrier_History_Statuses_StatusId",
                    column: x => x.StatusId,
                    principalTable: "Statuses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Carrier_History_USDOT_History_USDOT_HistoryId",
                    column: x => x.USDOT_HistoryId,
                    principalTable: "USDOT_History",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Trailers",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                SCT = table.Column<long>(type: "bigint", nullable: true),
                Model = table.Column<long>(type: "bigint", nullable: true),
                Maintenance = table.Column<long>(type: "bigint", nullable: true),
                Carrier = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false),
                Common = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Trailers", x => x.Id);
                table.ForeignKey(
                    name: "FK_Trailers_Carriers_Carrier",
                    column: x => x.Carrier,
                    principalTable: "Carriers",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trailers_Maintenances_Maintenance",
                    column: x => x.Maintenance,
                    principalTable: "Maintenances",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trailers_SCTs_SCT",
                    column: x => x.SCT,
                    principalTable: "SCTs",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Trailers_Trailers_Commons_Common",
                    column: x => x.Common,
                    principalTable: "Trailers_Commons",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Trailers_Vehicule_Models_Model",
                    column: x => x.Model,
                    principalTable: "Vehicule_Models",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Trailers_Externals",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Carrier = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                MxPlate = table.Column<string>(type: "nvarchar(7)", maxLength: 7, nullable: true),
                UsaPlate = table.Column<string>(type: "nvarchar(7)", maxLength: 7, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false),
                Common = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Trailers_Externals", x => x.Id);
                table.ForeignKey(
                    name: "FK_Trailers_Externals_Trailers_Commons_Common",
                    column: x => x.Common,
                    principalTable: "Trailers_Commons",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateTable(
            name: "Truck_History",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                VIN = table.Column<string>(type: "nvarchar(17)", maxLength: 17, nullable: false),
                Economic = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: false),
                Motor = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: true),
                Insurance_HistoryId = table.Column<long>(type: "bigint", nullable: true),
                Maintenance_HistoryId = table.Column<long>(type: "bigint", nullable: true),
                ManufacturerId = table.Column<long>(type: "bigint", nullable: true),
                TruckId = table.Column<long>(type: "bigint", nullable: true),
                VehiculeModelId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                Sequence = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Truck_History", x => x.Id);
                table.ForeignKey(
                    name: "FK_Truck_History_Insurance_History_Insurance_HistoryId",
                    column: x => x.Insurance_HistoryId,
                    principalTable: "Insurance_History",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Truck_History_Maintenance_History_Maintenance_HistoryId",
                    column: x => x.Maintenance_HistoryId,
                    principalTable: "Maintenance_History",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Truck_History_Manufacturers_ManufacturerId",
                    column: x => x.ManufacturerId,
                    principalTable: "Manufacturers",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Truck_History_Trucks_TruckId",
                    column: x => x.TruckId,
                    principalTable: "Trucks",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Truck_History_Vehicule_Models_VehiculeModelId",
                    column: x => x.VehiculeModelId,
                    principalTable: "Vehicule_Models",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Plates",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Identifier = table.Column<string>(type: "nvarchar(12)", maxLength: 12, nullable: false),
                Country = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: false),
                State = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: true),
                Expiration = table.Column<DateOnly>(type: "date", nullable: true),
                Status = table.Column<long>(type: "bigint", nullable: false),
                TrailerId = table.Column<long>(type: "bigint", nullable: true),
                TruckId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Plates", x => x.Id);
                table.ForeignKey(
                    name: "FK_Plates_Statuses_Status",
                    column: x => x.Status,
                    principalTable: "Statuses",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Plates_Trailers_TrailerId",
                    column: x => x.TrailerId,
                    principalTable: "Trailers",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Plates_Trucks_TruckId",
                    column: x => x.TruckId,
                    principalTable: "Trucks",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Yard_Logs",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Entry = table.Column<bool>(type: "bit", nullable: false),
                Seal = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: true),
                SealAlt = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: true),
                FromTo = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Evidence = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                Damage = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                LoadType = table.Column<long>(type: "bigint", nullable: false),
                Guard = table.Column<long>(type: "bigint", nullable: false),
                Section = table.Column<long>(type: "bigint", nullable: false),
                Driver = table.Column<long>(type: "bigint", nullable: false),
                Truck = table.Column<long>(type: "bigint", nullable: false),
                Trailer = table.Column<long>(type: "bigint", nullable: true),
                TrailerId = table.Column<long>(type: "bigint", nullable: true),
                TruckId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Yard_Logs", x => x.Id);
                table.ForeignKey(
                    name: "FK_Yard_Logs_Drivers_Commons_Driver",
                    column: x => x.Driver,
                    principalTable: "Drivers_Commons",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Yard_Logs_Employees_Guard",
                    column: x => x.Guard,
                    principalTable: "Employees",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Yard_Logs_LoadTypes_LoadType",
                    column: x => x.LoadType,
                    principalTable: "LoadTypes",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Yard_Logs_Sections_Section",
                    column: x => x.Section,
                    principalTable: "Sections",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Yard_Logs_Trailers_Commons_Trailer",
                    column: x => x.Trailer,
                    principalTable: "Trailers_Commons",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Yard_Logs_Trailers_TrailerId",
                    column: x => x.TrailerId,
                    principalTable: "Trailers",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Yard_Logs_TrucksCommons_Truck",
                    column: x => x.Truck,
                    principalTable: "TrucksCommons",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Yard_Logs_Trucks_TruckId",
                    column: x => x.TruckId,
                    principalTable: "Trucks",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateTable(
            name: "Plate_History",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Identifier = table.Column<string>(type: "nvarchar(max)", nullable: false),
                Country = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: false),
                State = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: true),
                Expiration = table.Column<DateOnly>(type: "date", nullable: true),
                PlateId = table.Column<long>(type: "bigint", nullable: true),
                StatusId = table.Column<long>(type: "bigint", nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                Sequence = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Plate_History", x => x.Id);
                table.ForeignKey(
                    name: "FK_Plate_History_Plates_PlateId",
                    column: x => x.PlateId,
                    principalTable: "Plates",
                    principalColumn: "Id");
                table.ForeignKey(
                    name: "FK_Plate_History_Statuses_StatusId",
                    column: x => x.StatusId,
                    principalTable: "Statuses",
                    principalColumn: "Id");
            });

        migrationBuilder.CreateIndex(
            name: "IX_Approach_History_ApproachId",
            table: "Approach_History",
            column: "ApproachId");

        migrationBuilder.CreateIndex(
            name: "IX_Approach_History_StatusId",
            table: "Approach_History",
            column: "StatusId");

        migrationBuilder.CreateIndex(
            name: "IX_Approaches_Status",
            table: "Approaches",
            column: "Status",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Carrier_History_AddressId",
            table: "Carrier_History",
            column: "AddressId");

        migrationBuilder.CreateIndex(
            name: "IX_Carrier_History_Approach_HistoryId",
            table: "Carrier_History",
            column: "Approach_HistoryId");

        migrationBuilder.CreateIndex(
            name: "IX_Carrier_History_CarrierId",
            table: "Carrier_History",
            column: "CarrierId");

        migrationBuilder.CreateIndex(
            name: "IX_Carrier_History_SCT_HistoryId",
            table: "Carrier_History",
            column: "SCT_HistoryId");

        migrationBuilder.CreateIndex(
            name: "IX_Carrier_History_StatusId",
            table: "Carrier_History",
            column: "StatusId");

        migrationBuilder.CreateIndex(
            name: "IX_Carrier_History_USDOT_HistoryId",
            table: "Carrier_History",
            column: "USDOT_HistoryId");

        migrationBuilder.CreateIndex(
            name: "IX_Carriers_Address",
            table: "Carriers",
            column: "Address");

        migrationBuilder.CreateIndex(
            name: "IX_Carriers_Approach",
            table: "Carriers",
            column: "Approach");

        migrationBuilder.CreateIndex(
            name: "IX_Carriers_Name",
            table: "Carriers",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Carriers_Status",
            table: "Carriers",
            column: "Status",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Carriers_USDOT",
            table: "Carriers",
            column: "USDOT");

        migrationBuilder.CreateIndex(
            name: "IX_Drivers_Common",
            table: "Drivers",
            column: "Common",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Drivers_Employee",
            table: "Drivers",
            column: "Employee",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Drivers_Commons_Situation",
            table: "Drivers_Commons",
            column: "Situation");

        migrationBuilder.CreateIndex(
            name: "IX_Drivers_Commons_Status",
            table: "Drivers_Commons",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_Drivers_Externals_Common",
            table: "Drivers_Externals",
            column: "Common",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Drivers_Externals_Identification",
            table: "Drivers_Externals",
            column: "Identification",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Employees_Address",
            table: "Employees",
            column: "Address");

        migrationBuilder.CreateIndex(
            name: "IX_Employees_Approach",
            table: "Employees",
            column: "Approach");

        migrationBuilder.CreateIndex(
            name: "IX_Employees_Dates",
            table: "Employees",
            column: "Dates",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Employees_Identification",
            table: "Employees",
            column: "Identification",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Employees_Status",
            table: "Employees",
            column: "Status",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Identifications_Status",
            table: "Identifications",
            column: "Status",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Insurance_History_InsuranceId",
            table: "Insurance_History",
            column: "InsuranceId");

        migrationBuilder.CreateIndex(
            name: "IX_Insurance_History_StatusId",
            table: "Insurance_History",
            column: "StatusId");

        migrationBuilder.CreateIndex(
            name: "IX_Insurances_Status",
            table: "Insurances",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_Inventory_Trucks_Section",
            table: "Inventory_Trucks",
            column: "Section");

        migrationBuilder.CreateIndex(
            name: "IX_Inventory_Trucks_Truck",
            table: "Inventory_Trucks",
            column: "Truck");

        migrationBuilder.CreateIndex(
            name: "IX_LoadTypes_Name",
            table: "LoadTypes",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Locations_Address",
            table: "Locations",
            column: "Address");

        migrationBuilder.CreateIndex(
            name: "IX_Locations_Name",
            table: "Locations",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Locations_Status",
            table: "Locations",
            column: "Status",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Maintenance_History_MaintenanceId",
            table: "Maintenance_History",
            column: "MaintenanceId");

        migrationBuilder.CreateIndex(
            name: "IX_Maintenance_History_StatusId",
            table: "Maintenance_History",
            column: "StatusId");

        migrationBuilder.CreateIndex(
            name: "IX_Maintenances_Status",
            table: "Maintenances",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_Manufacturers_Name",
            table: "Manufacturers",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Plate_History_PlateId",
            table: "Plate_History",
            column: "PlateId");

        migrationBuilder.CreateIndex(
            name: "IX_Plate_History_StatusId",
            table: "Plate_History",
            column: "StatusId");

        migrationBuilder.CreateIndex(
            name: "IX_Plates_Status",
            table: "Plates",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_Plates_TrailerId",
            table: "Plates",
            column: "TrailerId");

        migrationBuilder.CreateIndex(
            name: "IX_Plates_TruckId",
            table: "Plates",
            column: "TruckId");

        migrationBuilder.CreateIndex(
            name: "IX_SCT_History_SCTId",
            table: "SCT_History",
            column: "SCTId");

        migrationBuilder.CreateIndex(
            name: "IX_SCTs_Status",
            table: "SCTs",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_Sections_Name",
            table: "Sections",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Sections_Status",
            table: "Sections",
            column: "Status",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Sections_Yard",
            table: "Sections",
            column: "Yard");

        migrationBuilder.CreateIndex(
            name: "IX_Situations_Name",
            table: "Situations",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Statuses_Name",
            table: "Statuses",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Trailer_Classes_Name",
            table: "Trailer_Classes",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Trailer_Types_Class",
            table: "Trailer_Types",
            column: "Class");

        migrationBuilder.CreateIndex(
            name: "IX_Trailer_Types_Status",
            table: "Trailer_Types",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Carrier",
            table: "Trailers",
            column: "Carrier");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Common",
            table: "Trailers",
            column: "Common",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Maintenance",
            table: "Trailers",
            column: "Maintenance");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Model",
            table: "Trailers",
            column: "Model");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_SCT",
            table: "Trailers",
            column: "SCT");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Commons_Location",
            table: "Trailers_Commons",
            column: "Location");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Commons_Situation",
            table: "Trailers_Commons",
            column: "Situation");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Commons_Status",
            table: "Trailers_Commons",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Commons_Type",
            table: "Trailers_Commons",
            column: "Type");

        migrationBuilder.CreateIndex(
            name: "IX_Trailers_Externals_Common",
            table: "Trailers_Externals",
            column: "Common",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Truck_History_Insurance_HistoryId",
            table: "Truck_History",
            column: "Insurance_HistoryId");

        migrationBuilder.CreateIndex(
            name: "IX_Truck_History_Maintenance_HistoryId",
            table: "Truck_History",
            column: "Maintenance_HistoryId");

        migrationBuilder.CreateIndex(
            name: "IX_Truck_History_ManufacturerId",
            table: "Truck_History",
            column: "ManufacturerId");

        migrationBuilder.CreateIndex(
            name: "IX_Truck_History_TruckId",
            table: "Truck_History",
            column: "TruckId");

        migrationBuilder.CreateIndex(
            name: "IX_Truck_History_VehiculeModelId",
            table: "Truck_History",
            column: "VehiculeModelId");

        migrationBuilder.CreateIndex(
            name: "IX_Trucks_Carrier",
            table: "Trucks",
            column: "Carrier");

        migrationBuilder.CreateIndex(
            name: "IX_Trucks_Common",
            table: "Trucks",
            column: "Common",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Trucks_InsuranceId",
            table: "Trucks",
            column: "InsuranceId");

        migrationBuilder.CreateIndex(
            name: "IX_Trucks_Maintenance",
            table: "Trucks",
            column: "Maintenance");

        migrationBuilder.CreateIndex(
            name: "IX_Trucks_Model",
            table: "Trucks",
            column: "Model");

        migrationBuilder.CreateIndex(
            name: "IX_Trucks_SCT",
            table: "Trucks",
            column: "SCT");

        migrationBuilder.CreateIndex(
            name: "IX_Trucks_Externals_Common",
            table: "Trucks_Externals",
            column: "Common",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_TrucksCommons_Location",
            table: "TrucksCommons",
            column: "Location");

        migrationBuilder.CreateIndex(
            name: "IX_TrucksCommons_Situation",
            table: "TrucksCommons",
            column: "Situation");

        migrationBuilder.CreateIndex(
            name: "IX_TrucksCommons_Status",
            table: "TrucksCommons",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_USDOT_History_USDOTId",
            table: "USDOT_History",
            column: "USDOTId");

        migrationBuilder.CreateIndex(
            name: "IX_USDOTs_Status",
            table: "USDOTs",
            column: "Status",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Vehicule_Models_Manufacturer",
            table: "Vehicule_Models",
            column: "Manufacturer");

        migrationBuilder.CreateIndex(
            name: "IX_Vehicule_Models_Name",
            table: "Vehicule_Models",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Vehicule_Models_Status",
            table: "Vehicule_Models",
            column: "Status");

        migrationBuilder.CreateIndex(
            name: "IX_Yard_Logs_Driver",
            table: "Yard_Logs",
            column: "Driver",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Yard_Logs_Guard",
            table: "Yard_Logs",
            column: "Guard",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Yard_Logs_LoadType",
            table: "Yard_Logs",
            column: "LoadType");

        migrationBuilder.CreateIndex(
            name: "IX_Yard_Logs_Section",
            table: "Yard_Logs",
            column: "Section");

        migrationBuilder.CreateIndex(
            name: "IX_Yard_Logs_Trailer",
            table: "Yard_Logs",
            column: "Trailer",
            unique: true,
            filter: "[Trailer] IS NOT NULL");

        migrationBuilder.CreateIndex(
            name: "IX_Yard_Logs_TrailerId",
            table: "Yard_Logs",
            column: "TrailerId");

        migrationBuilder.CreateIndex(
            name: "IX_Yard_Logs_Truck",
            table: "Yard_Logs",
            column: "Truck",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Yard_Logs_TruckId",
            table: "Yard_Logs",
            column: "TruckId");
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder) {
        migrationBuilder.DropTable(
            name: "Carrier_History");

        migrationBuilder.DropTable(
            name: "Drivers");

        migrationBuilder.DropTable(
            name: "Drivers_Externals");

        migrationBuilder.DropTable(
            name: "Inventory_Trucks");

        migrationBuilder.DropTable(
            name: "Plate_History");

        migrationBuilder.DropTable(
            name: "Trailers_Externals");

        migrationBuilder.DropTable(
            name: "Truck_History");

        migrationBuilder.DropTable(
            name: "Trucks_Externals");

        migrationBuilder.DropTable(
            name: "Yard_Logs");

        migrationBuilder.DropTable(
            name: "Approach_History");

        migrationBuilder.DropTable(
            name: "SCT_History");

        migrationBuilder.DropTable(
            name: "USDOT_History");

        migrationBuilder.DropTable(
            name: "Plates");

        migrationBuilder.DropTable(
            name: "Insurance_History");

        migrationBuilder.DropTable(
            name: "Maintenance_History");

        migrationBuilder.DropTable(
            name: "Drivers_Commons");

        migrationBuilder.DropTable(
            name: "Employees");

        migrationBuilder.DropTable(
            name: "LoadTypes");

        migrationBuilder.DropTable(
            name: "Sections");

        migrationBuilder.DropTable(
            name: "Trailers");

        migrationBuilder.DropTable(
            name: "Trucks");

        migrationBuilder.DropTable(
            name: "Employee_Dates");

        migrationBuilder.DropTable(
            name: "Identifications");

        migrationBuilder.DropTable(
            name: "Trailers_Commons");

        migrationBuilder.DropTable(
            name: "Carriers");

        migrationBuilder.DropTable(
            name: "Insurances");

        migrationBuilder.DropTable(
            name: "Maintenances");

        migrationBuilder.DropTable(
            name: "SCTs");

        migrationBuilder.DropTable(
            name: "TrucksCommons");

        migrationBuilder.DropTable(
            name: "Vehicule_Models");

        migrationBuilder.DropTable(
            name: "Trailer_Types");

        migrationBuilder.DropTable(
            name: "Approaches");

        migrationBuilder.DropTable(
            name: "USDOTs");

        migrationBuilder.DropTable(
            name: "Locations");

        migrationBuilder.DropTable(
            name: "Situations");

        migrationBuilder.DropTable(
            name: "Manufacturers");

        migrationBuilder.DropTable(
            name: "Trailer_Classes");

        migrationBuilder.DropTable(
            name: "Addresses");

        migrationBuilder.DropTable(
            name: "Statuses");
    }
}
