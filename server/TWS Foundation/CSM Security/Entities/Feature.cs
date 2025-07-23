using CSM_Foundation.Database.Entity;

using CSM_Security.Abstractions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     [Entity] that represents a complex Feature storing different actions, this to determine Feature Scoped permits.
///     only for authorization purposes.
/// </summary>
public class Feature
    : BNamedEntity {

    #region Properties

    /// <summary>
    ///     Wheter it's enabled.
    /// </summary>
    public bool Enabled { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Permit"/> dependants from this <see cref="Feature"/>.
    /// </summary>
    [Relation]
    public ICollection<Permit> Permits { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Enabled)).IsRequired();
    }
}
