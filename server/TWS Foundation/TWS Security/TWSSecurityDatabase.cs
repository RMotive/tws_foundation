using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;

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

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<AccountPermit> AccountsPermits { get; set; }

    public virtual DbSet<AccountProfile> AccountsProfiles { get; set; }

    public virtual DbSet<Contact> Contacts { get; set; }

    public virtual DbSet<Feature> Features { get; set; }

    public virtual DbSet<Permit> Permits { get; set; }

    public virtual DbSet<Profile> Profiles { get; set; }

    public virtual DbSet<ProfilePermit> ProfilesPermits { get; set; }

    public virtual DbSet<Solution> Solutions { get; set; }

    protected override IDatabasesSet[] EvaluateFactory() {
        return [
            new Solution(),
        ];
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder) {
        modelBuilder.Entity<Account>(entity => {
            _ = entity.HasKey(e => e.Id);

            _ = entity.HasIndex(e => e.User).IsUnique();

            _ = entity.HasIndex(e => e.Contact).IsUnique();

            _ = entity.Property(e => e.Id);
            _ = entity.Property(e => e.Password);
            _ = entity.Property(e => e.User)
                .HasMaxLength(50)
                .IsUnicode(false);

            _ = entity.HasOne(d => d.ContactNavigation).WithOne(p => p.Account)
                .HasForeignKey<Account>(d => d.Contact)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });


        AccountPermit.CreateModel(modelBuilder);
        AccountProfile.CreateModel(modelBuilder);   
        ProfilePermit.CreateModel(modelBuilder);

        modelBuilder.Entity<Contact>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.Phone)
                .IsUnique();

            entity.HasIndex(e => e.Email)
                .IsUnique();

            entity.Property(e => e.Id);
            entity.Property(e => e.Email)
                .HasMaxLength(30)
                .IsUnicode(false);
            entity.Property(e => e.Lastname)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Phone)
                .HasMaxLength(14)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Feature>(entity => {
            _ = entity.HasKey(e => e.Id);

            _ = entity.HasIndex(e => e.Name, "UQ__Features__737584F6AD8F8134").IsUnique();

            _ = entity.Property(e => e.Id);
            _ = entity.Property(e => e.Name).HasMaxLength(25);
        });

        modelBuilder.Entity<Permit>(entity => {
            _ = entity.HasKey(e => e.Id);

            _ = entity.HasIndex(e => e.Reference).IsUnique();

            _ = entity.HasIndex(e => e.Name).IsUnique();

            _ = entity.Property(e => e.Id);
            _ = entity.Property(e => e.Description)
                .IsUnicode(false);
            _ = entity.Property(e => e.Name)
                .HasMaxLength(25)
                .IsUnicode(false);
            _ = entity.Property(e => e.Reference)
                .HasMaxLength(20)
                .IsUnicode(false);
            _ = entity.Property(e => e.Solution);

            _ = entity.HasOne(d => d.SolutionNavigation).WithMany(p => p.Permits)
                .HasForeignKey(d => d.Solution)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Profile>(entity => {
            _ = entity.HasKey(e => e.Id);

            _ = entity.HasIndex(e => e.Name).IsUnique();

            _ = entity.Property(e => e.Id);
            _ = entity.Property(e => e.Description)
                .IsUnicode(false);
            _ = entity.Property(e => e.Name)
                .HasMaxLength(25)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Solution>(entity => {
            _ = entity.HasKey(e => e.Id);

            _ = entity.HasIndex(e => e.Sign).IsUnique();

            _ = entity.HasIndex(e => e.Name).IsUnique();

            _ = entity.Property(e => e.Id);
            _ = entity.Property(e => e.Description)
                .IsUnicode(false);
            _ = entity.Property(e => e.Name)
                .HasMaxLength(25)
                .IsUnicode(false);
            _ = entity.Property(e => e.Sign)
                .HasMaxLength(5)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
