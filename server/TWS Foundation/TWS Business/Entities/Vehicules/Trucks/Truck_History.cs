using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;

using TWS_Business.Bases;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;

namespace TWS_Business.Entities.Vehicules.Trucks;

/// <summary>
///     [History Entity] for <see cref="Truck"/> Entity.
/// </summary>
public class Truck_History
    : BHistory<Truck> {

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
    [EntityDependant("Status", typeof(Status))]
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Vehicules.Manufacturer"/>
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Manufacturer", typeof(Manufacturer))]
    public Manufacturer Manufacturer { get; set; } = default!;

    /// <summary>
    ///     <see cref="Carrier_History"/> Carrier history entry.
    /// </summary>
    [EntityDependant("CarrierH", typeof(Carrier_History))]
    public Carrier_History? CarrierH { get; set; }

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    [EntityDependant("Situation", typeof(Situation))]
    public Situation? Situation { get; set; }

    /// <summary>
    ///     <see cref="Maintenance_History"/> history information.
    /// </summary>
    [EntityDependant("MaintenanceH", typeof(Maintenance_History))]
    public Maintenance_History? MaintenanceH { get; set; }

    /// <summary>
    ///     <see cref="Insurance_History"/> history information
    /// </summary>
    [EntityDependant("InsuranceH", typeof(Insurance_History))]
    public Insurance_History? InsuranceH { get; set; }

    #endregion
}