using CSM_Security.Abstractions;

using CSM_Database_Core.Core.Attributes;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     [Entity] that stores information for business environment solution.
/// </summary>
public class Solution
    : BNamedEntity {

    #region Properties

    /// <summary>
    ///     Solution unique sign to reference easyly the solution along operations.
    /// </summary>
    /// <remarks>
    ///     Must be unique along records. 5 Restricted Length.
    /// </remarks>
    public string Sign { get; set; } = string.Empty;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Permit"/> dependants from this <see cref="Solution"/>.
    /// </summary>
    [EntityDependency("Permits", typeof(Permit), isCollection:true)]
    public ICollection<Permit> Permits { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Sign)).IsFixedLength().HasMaxLength(5).IsRequired();
        etBuilder.HasIndex(nameof(Sign)).IsUnique();
    }
}
