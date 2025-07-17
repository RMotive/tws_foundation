using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules.Trailers;

using BNamedReferencedEntity = TWS_Business.Bases.BNamedReferencedEntity;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [etBuilder] that stores information about a specific type of load for <see cref="Trailer"/> loading information.
/// </summary>
public class LoadType
    : BNamedReferencedEntity {

    #region Dependants

    /// <summary>
    ///     <see cref="YardLog"/> dependants from this <see cref="LoadType"/>.
    /// </summary>

    public ICollection<YardLog> YardLogs { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder
            .Property(nameof(Reference))
            .HasMaxLength(8)
            .IsRequired()
            .IsFixedLength();

        etBuilder
            .HasIndex(nameof(Reference))
            .IsUnique();
    }
}
