using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Security.Sets.Contacts;

namespace TWS_Security.Sets.Accounts;

public partial class Account
    : BEntity {
    

    

    public string User { get; set; } = null!;

    public byte[] Password { get; set; } = null!;

    public bool Wildcard { get; set; }

    public int Contact { get; set; }

    public Contact? ContactNavigation { get; set; } = default!;


    public ICollection<Permit> Permits { get; set; } = [];

    public ICollection<Profile> Profiles { get; set; } = [];

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
                    .HasIndex(e => e.User)
                    .IsUnique();
                EntityBuilder
                    .Property(e => e.User)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                EntityBuilder
                    .HasIndex(e => e.Contact);

                EntityBuilder
                    .Property(e => e.Password);

                EntityBuilder
                    .HasOne(d => d.ContactNavigation)
                    .WithOne(p => p.Account)
                    .HasForeignKey<Account>(d => d.Contact)
                    .OnDelete(DeleteBehavior.ClientSetNull);

                EntityBuilder
                    .HasMany(i => i.Permits)
                    .WithMany(i => i.Accounts)
                    .UsingEntity<Dictionary<string, object>>(
                        ConnectorsConstants.AccountsPermits.Connector,
                        con => con.HasOne<Permit>().WithMany().HasForeignKey(ConnectorsConstants.AccountsPermits.Permit),
                        con => con.HasOne<Account>().WithMany().HasForeignKey(ConnectorsConstants.AccountsPermits.Account)
                    );

                EntityBuilder
                    .HasMany(i => i.Profiles)
                    .WithMany(i => i.Accounts)
                    .UsingEntity<Dictionary<string, object>>(
                        ConnectorsConstants.AccountsProfiles.Connector,
                        con => con.HasOne<Profile>().WithMany().HasForeignKey(ConnectorsConstants.AccountsProfiles.Profile),
                        con => con.HasOne<Account>().WithMany().HasForeignKey(ConnectorsConstants.AccountsProfiles.Account)
                    );
            }
        );
    }
}
