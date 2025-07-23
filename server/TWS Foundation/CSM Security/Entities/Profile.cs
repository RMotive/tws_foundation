using CSM_Foundation.Database.Entity;

using CSM_Security.Abstractions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     [Entity] that stores a relation between a collection of <see cref="Permit"/> with an <see cref="Account"/>
/// </summary>
public class Profile
    : BNamedEntity {

    #region Relations

    /// <summary>
    ///     <see cref="Permit"/> related to this <see cref="Profile"/>.
    /// </summary>
    [Relation]
    public ICollection<Permit> Permits { get; set; } = default!;

    /// <summary>
    ///     <see cref="Account"/> related to this <see cref="Profile"/>.
    /// </summary>
    [Relation]
    public ICollection<Account> Accounts { get; set; } = default!;

    #endregion

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
