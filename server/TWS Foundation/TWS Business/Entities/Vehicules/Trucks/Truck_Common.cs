using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;

namespace TWS_Business.Entities.Vehicules.Trucks;

/// <summary>
///     [Entity] that stores shared information along trucks. (<see cref="Truck"/> / <see cref="TruckExternal"/>).
/// </summary>
public class Truck_Common
    : BCommonEntity<Truck, TruckExternal> {

    #region Properties

    /// <summary>
    ///     Business economic identifier.
    /// </summary>
    [StringLength(16, MinimumLength = 1)]
    public string Economic { get; set; } = null!;

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Location"/> information.
    /// </summary>
    [Relation]
    public Location? Location { get; set; }

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    [Relation]
    public Situation? Situation { get; set; }

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Status Status { get; set; } = default!;

    #endregion

    #region dependants

    /// <summary>
    ///     <see cref="YardLog"/> dependants from this <see cref="YardLog"/>.
    /// </summary>
    public ICollection<YardLog> Yardlogs { get; set; } = [];

    #endregion

    #region Dependants 

    #endregion

    #region Custom Getters

    /// <summary>
    ///     Gets the [Truck] mexican plate.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>.
    ///     for <see cref="Internal"/> also needs loaded <see cref="Truck.Plates"/>
    /// </remarks>
    public string? PlateMEX
        => Internal?.Plates?.LastOrDefault(i => i.Country == "MEX")?.Identifier ?? External?.MxPlate;

    /// <summary>
    ///     Gets the [Truck] usa plate.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>
    ///     for <see cref="Internal"/> also needs loaded <see cref="Truck.Plates"/>
    /// </remarks>
    public string? PlateUSA
        => Internal?.Plates?.LastOrDefault(i => i.Country == "USA")?.Identifier ?? External?.UsaPlate;

    #endregion

    protected override void DesignCommonEntity(EntityTypeBuilder etBuilder) {
        //etBuilder.ToTable("Trucks_Commons");

        etBuilder.Property(nameof(Economic)).HasMaxLength(16).IsRequired();

        etBuilder.Link<Truck_Common, Location>(
                nameof(Location),
                TargetReference: nameof(Entities.Location.Trucks)
            );
        etBuilder.Link<Truck_Common, Situation>(
                nameof(Situation),
                TargetReference: nameof(Entities.Situation.Trucks)
        );
        etBuilder.Link<Truck_Common, Status>(
                nameof(Status),
                TargetReference: nameof(Entities.Status.Trucks),
                Required: true,
                Auto: true
            );
    }
}
