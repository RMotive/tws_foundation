using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using CSM_Security.Abstractions;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     [Entity] that stores and handles specific Feature / Solution / Action authorization for Accounts.
/// </summary>
public class Permit
    : BNamedEntity {

    #region Properties

    /// <summary>
    ///     Unique identifier reference.
    /// </summary>
    /// <remarks>
    ///     Strictly 8 length value
    /// </remarks>
    [StringLength(8, MinimumLength = 8)]
    public string Reference { get; set; } = string.Empty;

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
    [Relation]
    public Solution Solution { get; set; } = default!;

    /// <summary>
    ///     Feature information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Feature Feature { get; set; } = default!;

    /// <summary>
    ///     Action information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Action Action { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Profile"/> dependants from this <see cref="Permit"/>.
    /// </summary>
    [Relation]
    public ICollection<Profile> Profiles { get; set; } = [];

    /// <summary>
    ///     <see cref="Account"/> dependants from this <see cref="Permit"/>.
    /// </summary>
    [Relation]
    public ICollection<Account> Accounts { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.HasIndex(nameof(Reference)).IsUnique();
        etBuilder.Property(nameof(Reference)).HasMaxLength(8).IsFixedLength().IsRequired();

        etBuilder.Property(nameof(Enabled)).IsRequired();

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