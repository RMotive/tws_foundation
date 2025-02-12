using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;

using TWS_Security.Sets;
using TWS_Security.Sets.Accounts;
using TWS_Security.Sets.Contacts;
using TWS_Security.Sets.Solutions;

namespace TWS_Security;

public partial class TWSSecurityDatabase : BDatabase_SQLServer<TWSSecurityDatabase> {
    public TWSSecurityDatabase(DbContextOptions<TWSSecurityDatabase> options)
        : base("TWSS", options) {
    }

    public TWSSecurityDatabase()
    : base("TWSS") {

    }

    public virtual DbSet<Account> Accounts { get; set; } = default!;

    public virtual DbSet<Contact> Contacts { get; set; } = default!;

    public virtual DbSet<Feature> Features { get; set; } = default!;

    public virtual DbSet<Permit> Permits { get; set; } = default!;

    public virtual DbSet<Profile> Profiles { get; set; } = default!;

    public virtual DbSet<Solution> Solutions { get; set; } = default!;

    public virtual DbSet<Sets.Action> Actions { get; set; } = default!;
}
