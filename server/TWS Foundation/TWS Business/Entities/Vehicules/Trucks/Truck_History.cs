using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;

namespace TWS_Business.Entities.Vehicules.Trucks;

/// <summary>
///     [History Entity] for <see cref="Truck"/> Entity.
/// </summary>
public class Truck_History
    : TWSHistory<Truck> {

    #region Properties

    /// <summary>
    ///     Vehicule Identifier Number.
    /// </summary>
    [StringLength(17, MinimumLength = 17)]
    public string VIN { get; set; } = string.Empty;

    /// <summary>
    ///     Internal business vehicule identifier.
    /// </summary>
    [StringLength(16, MinimumLength = 1)]
    public string Economic { get; set; } = string.Empty;

    /// <summary>
    ///     Unique motor identifier.
    /// </summary>
    [StringLength(16)]
    public string? Motor { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Vehicules.Manufacturer"/>
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Manufacturer Manufacturer { get; set; } = default!;

    /// <summary>
    ///     <see cref="Carrier_History"/> Carrier history entry.
    /// </summary>
    public Carrier_History? CarrierH { get; set; }

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    public Situation? Situation { get; set; }

    /// <summary>
    ///     <see cref="Maintenance_History"/> history information.
    /// </summary>
    public Maintenance_History? MaintenanceH { get; set; }

    /// <summary>
    ///     <see cref="Insurance_History"/> history information
    /// </summary>
    public Insurance_History? InsuranceH { get; set; }

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        UniqueValidator Unique = new();

        return [
            ..Container,
            (nameof(VIN), [Unique, new LengthValidator(17, 17)]),
            (nameof(Economic), [new LengthValidator(1, 16)]),
        ];
    }
}