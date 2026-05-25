using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Entities.Maintenances;

/// <summary>
///     [History Entity] for <see cref="Maintenance"/>
/// </summary>
public class Maintenance_History
    : BHistory<Maintenance> {

    #region Properties

    /// <summary>
    ///     Next scheduled anual maintenance.
    /// </summary>
    public DateTime Anual { get; set; }

    /// <summary>
    ///     Next scheduled trimestral maintenance.
    /// </summary>
    public DateTime Trimestral { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Status", typeof(Status))]
    public Status Status { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Truck_History"/> dependants from this <see cref="Maintenance_History"/>.
    /// </summary>
    [EntityDependency("TrucksHistories", typeof(Truck_History), isCollection:true)]
    public ICollection<Truck_History> TrucksHistories { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Maintenances_Histories");

        etBuilder.Property(nameof(Anual)).IsRequired();
        etBuilder.Property(nameof(Trimestral)).IsRequired();

        etBuilder.Link<Maintenance_History, Status>(
                nameof(Status),
                TargetReference: nameof(Status.MaintenancesHistories),
                Required: true,
                Auto: true
            );
    }
}
