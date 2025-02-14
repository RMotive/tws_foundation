using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;

using TWS_Security.Entities;
using TWS_Security.Entities.Accounts;
using TWS_Security.Entities.Contacts;
using TWS_Security.Entities.Solutions;

namespace TWS_Security;

public partial class SecurityDatabase : BDatabase_SQLServer<SecurityDatabase> {
    public SecurityDatabase(DbContextOptions<SecurityDatabase> options)
        : base("TWSS", options) {
    }

    public SecurityDatabase()
    : base("TWSS") {

    }

    public virtual DbSet<Account> Accounts { get; set; } = default!;

    public virtual DbSet<Contact> Contacts { get; set; } = default!;

    public virtual DbSet<Feature> Features { get; set; } = default!;

    public virtual DbSet<Permit> Permits { get; set; } = default!;

    public virtual DbSet<Profile> Profiles { get; set; } = default!;

    public virtual DbSet<Solution> Solutions { get; set; } = default!;

    public virtual DbSet<Entities.Action> Actions { get; set; } = default!;
}
