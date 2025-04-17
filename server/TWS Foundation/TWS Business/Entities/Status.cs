using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Entities;

/// <summary>
///     []
/// </summary>
public class Status
: BEntity, INamedEntity {

    #region Properites

    public string Name { get; set; } = default!;
    public string? Description { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="VehiculeModel"/> dependants from this <see cref="Status"/>.
    /// </summary>
    public ICollection<VehiculeModel> Models { get; set; } = [];

    /// <summary>
    ///     <see cref="Driver_Common"/> referencing to this <see cref="Status"/>.
    /// </summary>
    public ICollection<Driver_Common> Drivers { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck_Common"/> referencing to this <see cref="Status"/>.
    /// </summary>
    public ICollection<Truck_Common> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer_Common"/> referencing to this <see cref="Status"/>
    /// </summary>
    public ICollection<Trailer_Common> Trailers { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer_Type"/> dependants from this <see cref="Status"/>.
    /// </summary>
    public ICollection<Trailer_Type> TrailerTypes { get; set; } = [];

    /// <summary>
    ///     <see cref="SCT"/> dependants from this <see cref="Status"/>
    /// </summary>
    public ICollection<SCT> SCTs { get; set; } = [];

    /// <summary>
    ///     <see cref="Carrier_History"/> entries dependants from this <see cref="Status"/>.
    /// </summary>
    public ICollection<Carrier_History> CarriersHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="Approach_History"/> entries dependants from this <see cref="Status"/>.
    /// </summary>
    public ICollection<Approach_History> ApproachesHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="Insurance"/> dependants from this <see cref="Status"/>
    /// </summary>
    public ICollection<Insurance> Insurances { get; set; } = [];

    /// <summary>
    ///     <see cref="Insurance_History"/> dependants from this <see cref="Status"/>
    /// </summary>
    public ICollection<Insurance_History> InsurancesHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="Maintenances.Maintenance"/> dependants from this <see cref="Status"/>
    /// </summary>
    public ICollection<Maintenances.Maintenance> Maintenances { get; set; } = [];

    /// <summary>
    ///     <see cref="Maintenances.Maintenance_History"/> dependants from this <see cref="Status"/>
    /// </summary>
    public ICollection<Maintenances.Maintenance_History> MaintenancesHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="Plate"/> dependants from this <see cref="Status"/>.
    /// </summary>
    public ICollection<Plate> Plates { get; set; } = [];

    /// <summary>
    ///     <see cref="Plate_History"/> dependants from this <see cref="Status"/>.
    /// </summary>
    public ICollection<Plate_History> PlatesHistories { get; set; } = [];

    #endregion
}