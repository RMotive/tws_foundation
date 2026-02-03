using CSM_Security.Abstractions;

using CSM_Database_Core.Core.Attributes;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     [Entity] that represents the information for certain actions/operations to be performed to the Solutions.
/// </summary>
public class Action
    : BNamedEntity {

    #region Properties

    /// <summary>
    ///     Wheter the <see cref="Action"/> is enabled.
    /// </summary>
    public bool Enabled { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Permit"/> dependats from this <see cref="Action"/>.
    /// </summary>
    [EntityRelation]
    public ICollection<Permit> Permits { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Enabled)).IsRequired();
    }
}
