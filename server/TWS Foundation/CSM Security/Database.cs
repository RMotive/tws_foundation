using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Models.Options;

using CSM_Security.Entities.Accounts;
using CSM_Security.Entities.Contacts;
using CSM_Security.Entities.Features;
using CSM_Security.Entities.Permits;
using CSM_Security.Entities.Profiles;
using CSM_Security.Entities.Solutions;

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

    public Database(DatabasesLinkOptions Connection)
        : base("CSMS", Connection) {
    }

    public Database(DatabasesLinkOptions Connection, DbContextOptions<Database> Options)
        : base("CSMS", Connection, Options) {
    }

    public Database()
        : base("CSMS") {
    }

    public virtual DbSet<Account> Accounts { get; set; } = default!;

    public virtual DbSet<Contact> Contacts { get; set; } = default!;

    public virtual DbSet<Feature> Features { get; set; } = default!;

    public virtual DbSet<Permit> Permits { get; set; } = default!;

    public virtual DbSet<Profile> Profiles { get; set; } = default!;

    public virtual DbSet<Solution> Solutions { get; set; } = default!;

    public virtual DbSet<Entities.Actions.Action> Actions { get; set; } = default!;
}
