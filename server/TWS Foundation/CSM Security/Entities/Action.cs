using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     [Entity] that represents the information for certain actions/operations to be performed to the Solutions.
/// </summary>
public class Action
    : BEntity, INamedEntity {

    #region Properties
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }

    /// <summary>
    ///     Wheter the <see cref="Action"/> is enabled.
    /// </summary>
    public bool Enabled { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Permit"/> dependats from this <see cref="Action"/>.
    /// </summary>
    public ICollection<Permit> Permits { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Enabled)).IsRequired();
    }
}
