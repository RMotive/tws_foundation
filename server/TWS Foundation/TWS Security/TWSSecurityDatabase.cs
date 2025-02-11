﻿using CSM_Foundation.Database.Bases;
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

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
