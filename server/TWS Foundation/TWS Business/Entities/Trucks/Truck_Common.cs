using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Trucks;

/// <summary>
///     [Entity] that stores shared information along trucks. (<see cref="Truck"/> / <see cref="TruckExternal"/>).
/// </summary>
public class Truck_Common
    : TWSEntity {

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
    public Location? Location { get; set; }

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    public Situation? Situation { get; set; }

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Truck"/> information.
    /// </summary>
    public Truck? Internal { get; set; }

    /// <summary>
    ///     <see cref="TruckExternal"/> information.
    /// </summary>
    public TruckExternal? External { get; set; }

    #endregion

    #region Dependants 

    /// <summary>
    ///     <see cref="TruckEntry"/> dependants from this <see cref="Truck_Common"/>
    /// </summary>
    public ICollection<TruckEntry> TruckEntries { get; set; } = [];

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

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
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

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            (nameof(Economic), [ new LengthValidator(1, 16) ] ),
        ];
    }
}
