using CSM_Security.Abstractions;

using CSM_Database_Core.Core.Attributes;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using CSM_Database_Core.Core.Extensions;

namespace CSM_Security.Entities;

/// <summary>
///     [Entity] that stores and handles specific Feature / Solution / Action authorization for Accounts.
/// </summary>
public class Permit
    : CatalogEntity {

    #region Properties

    /// <summary>
    ///     Wheter the Permit is globally enabled.
    /// </summary>
    public bool Enabled { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     Solution information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Solution", typeof(Solution))]
    public Solution Solution { get; set; } = default!;

    /// <summary>
    ///     Feature information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Feature", typeof(Feature))]
    public Feature Feature { get; set; } = default!;

    /// <summary>
    ///     Action information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Action", typeof(Action))]
    public Action Action { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Profile"/> dependants from this <see cref="Permit"/>.
    /// </summary>
    [EntityDependency("Profiles", typeof(Profile), isCollection:true)]
    public ICollection<Profile> Profiles { get; set; } = [];

    /// <summary>
    ///     <see cref="Account"/> dependants from this <see cref="Permit"/>.
    /// </summary>
    [EntityDependency("Accounts", typeof(Account), isCollection:true)]
    public ICollection<Account> Accounts { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {

        etBuilder.Link<Permit, Solution>(
                nameof(Solution),
                isRequired: true,
                isAutoLoaded: true
            );
        etBuilder.Link<Permit, Feature>(
                nameof(Feature),
                isRequired: true,
                isAutoLoaded: true
            );
        etBuilder.Link<Permit, Action>(
                nameof(Action),
                isRequired: true,
                isAutoLoaded: true
            );
        etBuilder.HasIndex("ActionShadow", "SolutionShadow", "FeatureShadow");
    }

    /// <summary>
    ///     Stores a static catalog of <see cref="Permit"/> references.
    /// </summary>
    public enum References {
        /// <summary>
        ///     <para> Solution: TWSMF </para>
        ///     <para> Feature: Development </para>
        ///     <para> Action: Qualify </para>
        /// </summary>
        TWSMFD01,
    }
}