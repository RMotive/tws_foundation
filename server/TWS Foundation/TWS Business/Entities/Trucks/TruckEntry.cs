using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Trucks;

/// <summary>
///     [Entity] representing an entry on an inventory system for <see cref="Truck_Common"/> (trucks) into <see cref="YardLog"/>.
/// </summary>
public class TruckEntry
    : TWSEntity {

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Section"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Section Section { get; set; } = default!;

    /// <summary>
    ///     <see cref="Truck_Common"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Truck_Common Truck { get; set; } = default!;

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Inventory_Trucks");

        etBuilder.Link<TruckEntry, Section>(
                nameof(Section),
                TargetReference: nameof(Entities.Section.TrucksEntries),
                Required: true,
                Auto: true
            );
        etBuilder.Link<TruckEntry, Truck_Common>(
                nameof(Truck),
                TargetReference: nameof(Truck_Common.TrucksEntries),
                Required: true,
                Auto: true
            );
    }
}
