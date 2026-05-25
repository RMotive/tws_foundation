using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using BEntity = CSM_Security.Abstractions.BEntity;

namespace CSM_Security.Entities;

public class Account
    : BEntity {

    #region Properties

    /// <summary>
    ///     <see cref="Account"/> user identifier.
    /// </summary>
    [StringLength(50, MinimumLength = 1)]

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
    [EntityDependant("Contact", typeof(Contact))]
    public Contact Contact { get; set; } = default!;


    #endregion

    #region Dependents
    /// <summary>
    ///     <see cref="Permit"/> related to this <see cref="Account"/>
    /// </summary>
    [EntityDependency("Permits", typeof(Permit), isCollection:true)]
    public ICollection<Permit> Permits { get; set; } = [];

    /// <summary>
    ///     <see cref="Profile"/> related to this <see cref="Account"/>
    /// </summary>
    [EntityDependency("Profiles", typeof(Profile), isCollection:true)]
    public ICollection<Profile> Profiles { get; set; } = [];

    /// <summary>
    /// Collection of <see cref="Vendor"/> linked to this <see cref="Account"/>.
    /// </summary>
    [EntityDependency("Vendors", typeof(Vendor), isCollection:true)]
    public ICollection<Vendor> Vendors { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.HasIndex(nameof(User)).IsUnique();
        etBuilder.Property(nameof(User)).HasMaxLength(50).IsRequired();
        etBuilder.Property(nameof(Password)).IsRequired();

        etBuilder.Link<Account, Contact>(
                nameof(Contact),
                isRequired: true,
                isIndex: true,
                isAutoLoaded: true,
                deleteBehavior: DeleteBehavior.Cascade
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

        etBuilder
            .HasMany(nameof(Vendors))
            .WithMany(nameof(Vendor.Accounts))
            .UsingEntity(
                Constants.Connectors.AccountsVendors.Connector,
                con => con.HasOne(typeof(Vendor)).WithMany().HasForeignKey(Constants.Connectors.AccountsVendors.Vendor).OnDelete(DeleteBehavior.Cascade),
                con => con.HasOne(typeof(Account)).WithMany().HasForeignKey(Constants.Connectors.AccountsVendors.Account).OnDelete(DeleteBehavior.Cascade)
            );
    }
}
