using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Security.Sets.Contacts;

namespace TWS_Security.Sets.Accounts;

public partial class Account
    : BSet {
    

    

    public string User { get; set; } = null!;

    public byte[] Password { get; set; } = null!;

    public bool Wildcard { get; set; }

    public int Contact { get; set; }

    public Contact? ContactNavigation { get; set; } = default!;


    public ICollection<Permit> Permits { get; set; } = default!;

    public ICollection<Profile> Profiles { get; set; } = default!;

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(User), [ new UniqueValidator(), new RequiredValidator() ]),
            (nameof(Password), [ new RequiredValidator() ]),
            (nameof(Contact), [new PointerValidator(true)]),
        ];
        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Account>(
            (EntityBuilder) => {
                EntityBuilder
                    .HasKey(e => e.Id);

                EntityBuilder
                    .HasIndex(e => e.User)
                    .IsUnique();

                EntityBuilder
                    .HasIndex(e => e.Contact)
                    .IsUnique();

                EntityBuilder
                    .Property(e => e.Id);
                EntityBuilder
                    .Property(e => e.Password);
                EntityBuilder
                    .Property(e => e.User)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                EntityBuilder
                    .HasOne(d => d.ContactNavigation)
                    .WithOne(p => p.Account)
                    .HasForeignKey<Account>(d => d.Contact)
                    .OnDelete(DeleteBehavior.ClientSetNull);

                EntityBuilder
                    .HasMany(i => i.Permits)
                    .WithMany(i => i.Accounts)
                    .UsingEntity<Dictionary<string, object>>(
                        "AccountsPermits",
                        con => con.HasOne<Permit>().WithMany().HasForeignKey("Permit"),
                        con => con.HasOne<Account>().WithMany().HasForeignKey("Account")
                    );

                EntityBuilder
                    .HasMany(i => i.Profiles)
                    .WithMany(i => i.Accounts)
                    .UsingEntity<Dictionary<string, object>>(
                        "AccountsProfiles",
                        con => con.HasOne<Profile>().WithMany().HasForeignKey("Profile"),
                        con => con.HasOne<Account>().WithMany().HasForeignKey("Account")
                    );
            }
        );
    }
}
