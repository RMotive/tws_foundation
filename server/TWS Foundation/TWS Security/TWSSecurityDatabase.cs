using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;

using TWS_Security.Sets;

namespace TWS_Security;

public partial class TWSSecurityDatabase : BDatabaseSQLS<TWSSecurityDatabase> {
    public TWSSecurityDatabase(DbContextOptions<TWSSecurityDatabase> options)
        : base("TWSS", options) {
    }

    public TWSSecurityDatabase()
    : base("TWSS") {

    }

    public virtual DbSet<Account> Accounts { get; set; } = default!;

    public virtual DbSet<AccountPermit> AccountsPermits { get; set; } = default!;

    public virtual DbSet<AccountProfile> AccountsProfiles { get; set; } = default!;

    public virtual DbSet<Contact> Contacts { get; set; } = default!;

    public virtual DbSet<Feature> Features { get; set; } = default!;

    public virtual DbSet<Permit> Permits { get; set; } = default!;

    public virtual DbSet<Profile> Profiles { get; set; } = default!;

    public virtual DbSet<ProfilePermit> ProfilesPermits { get; set; } = default!;

    public virtual DbSet<Solution> Solutions { get; set; } = default!;

    public virtual DbSet<Sets.Action> Actions { get; set; } = default!;
}
