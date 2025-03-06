using CSM_Foundation.Database;
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Models;

using CSM_Security.Entities.Accounts;
using CSM_Security.Entities.Contacts;
using CSM_Security.Entities.Features;
using CSM_Security.Entities.Permits;
using CSM_Security.Entities.Profiles;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace CSM_Security;


public class DesignDatabaseFactory : IDesignTimeDbContextFactory<Database> {
    public Database CreateDbContext(string[] args) {
        return new Database();
    }
}

public class Database : BDatabase_SQLServer<Database> {
    public Database(DbContextOptions<Database> Options)
        : base("CSMS", Options) {
    }

    public Database(ConnectionOptions Connection)
        : base("CSMS", Connection) {
    }

    public Database(ConnectionOptions Connection, DbContextOptions<Database> Options)
        : base("CSMS", Connection, Options) {
    }

    public Database()
        : base("CSMS") {
    }

    public DbSet<Account> Accounts { get; set; } = default!;

    public DbSet<Contact> Contacts { get; set; } = default!;

    public DbSet<Feature> Features { get; set; } = default!;

    public DbSet<Permit> Permits { get; set; } = default!;

    public DbSet<Profile> Profiles { get; set; } = default!;

    public DbSet<CSM_Security.Entities.Solutions.Solution> Solutions { get; set; } = default!;

    public DbSet<Entities.Actions.Action> Actions { get; set; } = default!;
}
