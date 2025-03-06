using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using CSM_Security.Entities.Accounts;
using CSM_Security.Entities.Permits;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities.Profiles;

/// <summary>
///     [Entity] that stores a relation between a collection of <see cref="Permit"/> with an <see cref="Account"/>
/// </summary>
public class Profile
    : BEntity, IEntity_Name {

    #region Properties

    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Permit"/> related to this <see cref="Profile"/>.
    /// </summary>
    public ICollection<Permit> Permits { get; set; } = default!;

    /// <summary>
    ///     <see cref="Account"/> related to this <see cref="Profile"/>.
    /// </summary>
    public ICollection<Account> Accounts { get; set; } = default!;

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            (nameof(Name), [ new LengthValidator(1, 25), new UniqueValidator() ]),
        ];
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {

        etBuilder
            .HasMany(nameof(Permits))
            .WithMany(nameof(Permit.Profiles))
            .UsingEntity(
                "Profiles_Permits",
                con => con.HasOne(typeof(Permit)).WithMany().HasForeignKey("Permit"),
                con => con.HasOne(typeof(Profile)).WithMany().HasForeignKey("Profile")
            );

        etBuilder
            .HasMany(nameof(Accounts))
            .WithMany(nameof(Account.Profiles))
            .UsingEntity(
                "Accounts_Profiles",
                con => con.HasOne(typeof(Account)).WithMany().HasForeignKey("Account"),
                con => con.HasOne(typeof(Profile)).WithMany().HasForeignKey("Profile")
            );
    }
}
