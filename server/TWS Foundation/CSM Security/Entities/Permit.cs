using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;
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
    [EntityRelation]
    public Solution Solution { get; set; } = default!;

    /// <summary>
    ///     Feature information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityRelation]
    public Feature Feature { get; set; } = default!;

    /// <summary>
    ///     Action information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityRelation]
    public Action Action { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Profile"/> dependants from this <see cref="Permit"/>.
    /// </summary>
    [EntityRelation]
    public ICollection<Profile> Profiles { get; set; } = [];

    /// <summary>
    ///     <see cref="Account"/> dependants from this <see cref="Permit"/>.
    /// </summary>
    [EntityRelation]
    public ICollection<Account> Accounts { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {

        etBuilder.Link<Permit, Solution>(
                nameof(Solution),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Permit, Feature>(
                nameof(Feature),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Permit, Action>(
                nameof(Action),
                Required: true,
                Auto: true
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