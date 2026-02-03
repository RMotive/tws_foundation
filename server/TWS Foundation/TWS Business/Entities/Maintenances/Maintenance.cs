using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using BEntity = TWS_Business.Bases.BEntity;

namespace TWS_Business.Entities.Maintenances;

/// <summary>
///     [Entity] that stores information about maintenance scheduling for maintenable assets (<see cref="Truck"/> / <see cref="Trailer"/>)
/// </summary>
public class Maintenance
    : BEntity {

    #region Properties

    /// <summary>
    ///     Next anual maintenance scheduled.
    /// </summary>
    public DateOnly Anual { get; set; }

    /// <summary>
    ///     Next trimestral maintenance scheduled.
    /// </summary>
    public DateOnly Trimestral { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Trailer"/> dependants from this <see cref="Maintenance"/>
    /// </summary>
    public ICollection<Trailer> Trailers { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck"/> dependants from this <see cref="Maintenance"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    #endregion

    /// <summary>
    ///     History entries.
    /// </summary>
    public ICollection<Maintenance_History> History { get; set; } = [];


    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Anual)).IsRequired();
        etBuilder.Property(nameof(Trimestral)).IsRequired();

        etBuilder.Link<Maintenance, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
    }
}
