using CSM_Foundation.Database.Validators;

using CSM_Security.Entities.Contacts;
using CSM_Security.Entities.Permits;
using CSM_Security.Entities.Profiles;

using Microsoft.EntityFrameworkCore;

namespace CSM_Security.Entities.Accounts;

public partial class Account
    : BSecurityDatabaseEntity {

    /// <summary>
    ///     <see cref="Account"/> user identifier.
    /// </summary>
    public string User { get; set; } = string.Empty;

    /// <summary>
    ///     <see cref="Account"/> password
    /// </summary>
    public byte[] Password { get; set; } = null!;

    /// <summary>
    ///     Wheter have total free access with no verification.
    /// </summary>
    public bool Wildcard { get; set; }

    /// <summary>
    ///     Contact information.
    /// </summary>
    public Contact Contact { get; set; } = default!;

    /// <summary>
    ///     <see cref="Permit"/>s related to this <see cref="Account"/>
    /// </summary>
    public ICollection<Permit> Permits { get; set; } = [];

    /// <summary>
    ///     <see cref="Profile"/>s related to this <see cref="Account"/>
    /// </summary>
    public ICollection<Profile> Profiles { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(User), [ new UniqueValidator(), new RequiredValidator() ]),
            (nameof(Password), [ new RequiredValidator() ]),
        ];
        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Account>(
            (etBuilder) => {

                etBuilder.HasIndex(e => e.User).IsUnique();
                etBuilder.Property(e => e.User).HasMaxLength(50).IsRequired();

                etBuilder.Property<long>("ContactShadow").HasColumnName("Contact").IsRequired();
                etBuilder.HasIndex("ContactShadow");

                etBuilder.Property(e => e.Password).IsRequired();

                etBuilder
                    .HasOne(d => d.Contact)
                    .WithOne(p => p.Account)
                    .HasForeignKey<Account>("ContactShadow")
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Cascade);

                etBuilder
                    .HasMany(i => i.Permits)
                    .WithMany(i => i.Accounts)
                    .UsingEntity<Dictionary<string, object>>(
                        Constants.Connectors.AccountsPermits.Connector,
                        con => con.HasOne<Permit>().WithMany().HasForeignKey(Constants.Connectors.AccountsPermits.Permit).OnDelete(DeleteBehavior.Cascade),
                        con => con.HasOne<Account>().WithMany().HasForeignKey(Constants.Connectors.AccountsPermits.Account).OnDelete(DeleteBehavior.Cascade)
                    );

                etBuilder
                    .HasMany(i => i.Profiles)
                    .WithMany(i => i.Accounts)
                    .UsingEntity<Dictionary<string, object>>(
                        Constants.Connectors.AccountsProfiles.Connector,
                        con => con.HasOne<Profile>().WithMany().HasForeignKey(Constants.Connectors.AccountsProfiles.Profile).OnDelete(DeleteBehavior.Cascade),
                        con => con.HasOne<Account>().WithMany().HasForeignKey(Constants.Connectors.AccountsPermits.Account).OnDelete(DeleteBehavior.Cascade)
                    );
            }
        );
    }
}
