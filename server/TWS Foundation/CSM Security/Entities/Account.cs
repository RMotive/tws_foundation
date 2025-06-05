using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

public class Account
    : BEntity {

    #region Properties

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

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Contact"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Contact Contact { get; set; } = default!;

    /// <summary>
    ///     <see cref="Permit"/> related to this <see cref="Account"/>
    /// </summary>
    [Relation]
    public ICollection<Permit> Permits { get; set; } = [];

    /// <summary>
    ///     <see cref="Profile"/> related to this <see cref="Account"/>
    /// </summary>
    [Relation]
    public ICollection<Profile> Profiles { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.HasIndex(nameof(User)).IsUnique();
        etBuilder.Property(nameof(User)).HasMaxLength(50).IsRequired();
        etBuilder.Property(nameof(Password)).IsRequired();

        etBuilder.Link<Account, Contact>(
                nameof(Contact),
                Required: true,
                Index: true,
                Auto: true,
                Deletion: DeleteBehavior.Cascade
            );

        etBuilder
            .HasMany(nameof(Permits))
            .WithMany(nameof(Permit.Accounts))
            .UsingEntity(
                Constants.Connectors.AccountsPermits.Connector,
                con => con.HasOne(typeof(Permit)).WithMany().HasForeignKey(Constants.Connectors.AccountsPermits.Permit).OnDelete(DeleteBehavior.Cascade),
                con => con.HasOne(typeof(Account)).WithMany().HasForeignKey(Constants.Connectors.AccountsPermits.Account).OnDelete(DeleteBehavior.Cascade)
            );

        etBuilder
            .HasMany(nameof(Profiles))
            .WithMany(nameof(Profile.Accounts))
            .UsingEntity(
                Constants.Connectors.AccountsProfiles.Connector,
                con => con.HasOne(typeof(Profile)).WithMany().HasForeignKey(Constants.Connectors.AccountsProfiles.Profile).OnDelete(DeleteBehavior.Cascade),
                con => con.HasOne(typeof(Account)).WithMany().HasForeignKey(Constants.Connectors.AccountsPermits.Account).OnDelete(DeleteBehavior.Cascade)
            );
    }
}
