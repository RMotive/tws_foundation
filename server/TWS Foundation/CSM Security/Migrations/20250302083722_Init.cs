using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CSM_Security.Migrations;

/// <inheritdoc />
public partial class Init : Migration {
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder) {
        migrationBuilder.CreateTable(
            name: "Actions",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Enabled = table.Column<bool>(type: "bit", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Actions", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Contacts",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Lastname = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                Email = table.Column<string>(type: "varchar(30)", unicode: false, maxLength: 30, nullable: false),
                Phone = table.Column<string>(type: "varchar(14)", unicode: false, maxLength: 14, nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Contacts", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Features",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Enabled = table.Column<bool>(type: "bit", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Features", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Profiles",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Profiles", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Solutions",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                Sign = table.Column<string>(type: "nchar(5)", fixedLength: true, maxLength: 5, nullable: false),
                Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Solutions", x => x.Id);
            });

        migrationBuilder.CreateTable(
            name: "Accounts",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                User = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                Password = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                Wildcard = table.Column<bool>(type: "bit", nullable: false),
                Contact = table.Column<long>(type: "bigint", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Accounts", x => x.Id);
                table.ForeignKey(
                    name: "FK_Accounts_Contacts_Contact",
                    column: x => x.Contact,
                    principalTable: "Contacts",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateTable(
            name: "Permits",
            columns: table => new {
                Id = table.Column<long>(type: "bigint", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Solution = table.Column<long>(type: "bigint", nullable: false),
                Feature = table.Column<long>(type: "bigint", nullable: false),
                Action = table.Column<long>(type: "bigint", nullable: false),
                Reference = table.Column<string>(type: "nvarchar(450)", nullable: false),
                Enabled = table.Column<bool>(type: "bit", nullable: false),
                Timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Permits", x => x.Id);
                table.ForeignKey(
                    name: "FK_Permits_Actions_Action",
                    column: x => x.Action,
                    principalTable: "Actions",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Permits_Features_Feature",
                    column: x => x.Feature,
                    principalTable: "Features",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Permits_Solutions_Solution",
                    column: x => x.Solution,
                    principalTable: "Solutions",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateTable(
            name: "Accounts_Profiles",
            columns: table => new {
                Account = table.Column<long>(type: "bigint", nullable: false),
                Profile = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Accounts_Profiles", x => new { x.Account, x.Profile });
                table.ForeignKey(
                    name: "FK_Accounts_Profiles_Accounts_Account",
                    column: x => x.Account,
                    principalTable: "Accounts",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Accounts_Profiles_Profiles_Profile",
                    column: x => x.Profile,
                    principalTable: "Profiles",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateTable(
            name: "Accounts_Permits",
            columns: table => new {
                Account = table.Column<long>(type: "bigint", nullable: false),
                Permit = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Accounts_Permits", x => new { x.Account, x.Permit });
                table.ForeignKey(
                    name: "FK_Accounts_Permits_Accounts_Account",
                    column: x => x.Account,
                    principalTable: "Accounts",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Accounts_Permits_Permits_Permit",
                    column: x => x.Permit,
                    principalTable: "Permits",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateTable(
            name: "Profiles_Permits",
            columns: table => new {
                Permit = table.Column<long>(type: "bigint", nullable: false),
                Profile = table.Column<long>(type: "bigint", nullable: false)
            },
            constraints: table => {
                table.PrimaryKey("PK_Profiles_Permits", x => new { x.Permit, x.Profile });
                table.ForeignKey(
                    name: "FK_Profiles_Permits_Permits_Permit",
                    column: x => x.Permit,
                    principalTable: "Permits",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
                table.ForeignKey(
                    name: "FK_Profiles_Permits_Profiles_Profile",
                    column: x => x.Profile,
                    principalTable: "Profiles",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateIndex(
            name: "IX_Accounts_Contact",
            table: "Accounts",
            column: "Contact",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Accounts_User",
            table: "Accounts",
            column: "User",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Accounts_Permits_Permit",
            table: "Accounts_Permits",
            column: "Permit");

        migrationBuilder.CreateIndex(
            name: "IX_Accounts_Profiles_Profile",
            table: "Accounts_Profiles",
            column: "Profile");

        migrationBuilder.CreateIndex(
            name: "IX_Actions_Name",
            table: "Actions",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Contacts_Email",
            table: "Contacts",
            column: "EMail",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Contacts_Name",
            table: "Contacts",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Contacts_Phone",
            table: "Contacts",
            column: "Phone",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Features_Name",
            table: "Features",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Permits_Action_Solution_Feature",
            table: "Permits",
            columns: ["Action", "Solution", "Feature"],
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Permits_Feature",
            table: "Permits",
            column: "Feature");

        migrationBuilder.CreateIndex(
            name: "IX_Permits_Reference",
            table: "Permits",
            column: "Reference",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Permits_Solution",
            table: "Permits",
            column: "Solution");

        migrationBuilder.CreateIndex(
            name: "IX_Profiles_Name",
            table: "Profiles",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Profiles_Permits_Profile",
            table: "Profiles_Permits",
            column: "Profile");

        migrationBuilder.CreateIndex(
            name: "IX_Solutions_Name",
            table: "Solutions",
            column: "Name",
            unique: true);

        migrationBuilder.CreateIndex(
            name: "IX_Solutions_Sign",
            table: "Solutions",
            column: "Sign",
            unique: true);
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder) {
        migrationBuilder.DropTable(
            name: "Accounts_Permits");

        migrationBuilder.DropTable(
            name: "Accounts_Profiles");

        migrationBuilder.DropTable(
            name: "Profiles_Permits");

        migrationBuilder.DropTable(
            name: "Accounts");

        migrationBuilder.DropTable(
            name: "Permits");

        migrationBuilder.DropTable(
            name: "Profiles");

        migrationBuilder.DropTable(
            name: "Contacts");

        migrationBuilder.DropTable(
            name: "Actions");

        migrationBuilder.DropTable(
            name: "Features");

        migrationBuilder.DropTable(
            name: "Solutions");
    }
}
