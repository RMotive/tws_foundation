using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [etBuilder] that stores information about a specific type of load for <see cref="Trailer"/> loading information.
/// </summary>
public class LoadType
    : BEntity, IReferencedEntity {

    #region Properties

    [StringLength(100, MinimumLength = 1)]
    public string Name { get; set; } = default!;

    [StringLength(maximumLength: 200)]
    public string? Description { get; set; }

    [StringLength(8, MinimumLength = 8)]
    public string Reference { get; set; } = default!;

    #endregion

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
