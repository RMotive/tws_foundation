using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

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

    protected override ISet[] EvaluateFactory() {
        return [
            new Permit(),
            new Contact(),
            new Account(),
            new Feature(),
            new Solution(),
            new Sets.Action(),
        ];
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder) {
        Permit.CreateModel(modelBuilder);
        Contact.CreateModel(modelBuilder);
        Feature.CreateModel(modelBuilder);
        Solution.CreateModel(modelBuilder);
        Sets.Action.CreateModel(modelBuilder);
        Account.CreateModel(modelBuilder);
        AccountPermit.CreateModel(modelBuilder);
        AccountProfile.CreateModel(modelBuilder);
        ProfilePermit.CreateModel(modelBuilder);

        modelBuilder.Entity<Profile>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.Name).IsUnique();

            entity.Property(e => e.Id);
            entity.Property(e => e.Description)
                .IsUnicode(false);
            entity.Property(e => e.Name)
                .HasMaxLength(25)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
