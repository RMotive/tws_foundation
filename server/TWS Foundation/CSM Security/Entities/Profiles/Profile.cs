using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using CSM_Security.Entities.Accounts;
using CSM_Security.Entities.Permits;

using Microsoft.EntityFrameworkCore;

namespace CSM_Security.Entities.Profiles;

/// <summary>
///     Profile [Set] record object definition.
///     
///     A Profile stores a relation between a collection of <see cref="Permit"/> with an <see cref="Account"/>
/// </summary>
public partial class Profile
    : BSecurityDatabaseEntity, IEntity_Name {

    public string Name { get; set; } = default!;

    public string? Description { get; set; }

    public ICollection<Permit> Permits { get; set; } = default!;

    public ICollection<Account> Accounts { get; set; } = default!;

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            (nameof(Name), [ new LengthValidator(1, 25), new UniqueValidator() ]),
        ];
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Profile>(
            (EntityBuilder) => {

                EntityBuilder
                    .HasIndex(i => i.Name)
                    .IsUnique();

                EntityBuilder
                    .Property(i => i.Description);

                EntityBuilder
                    .HasMany(i => i.Permits)
                    .WithMany(i => i.Profiles)
                    .UsingEntity<Dictionary<string, object>>(
                        "Profiles_Permits",
                        con => con.HasOne<Permit>().WithMany().HasForeignKey("Permit"),
                        con => con.HasOne<Profile>().WithMany().HasForeignKey("Profile")
                    );

                EntityBuilder
                    .HasMany(i => i.Accounts)
                    .WithMany(i => i.Profiles)
                    .UsingEntity<Dictionary<string, object>>(
                        "Accounts_Profiles",
                        con => con.HasOne<Account>().WithMany().HasForeignKey("Account"),
                        con => con.HasOne<Profile>().WithMany().HasForeignKey("Profile")
                    );
            }
        );
    }
}
