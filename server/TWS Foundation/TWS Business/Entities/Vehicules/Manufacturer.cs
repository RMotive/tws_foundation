using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Entity.Bases;

using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [Entity] that stores information about certain manufacturers for <see cref="Trailer"/> and <see cref="Truck"/> data proccesses.
/// </summary>
public class Manufacturer
    : BEntity, BNamedEntity {

    #region Properties

    [StringLength(100, MinimumLength = 1)]
    public string Name { get; set; } = default!;

    [StringLength(maximumLength: 200)]
    public string? Description { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Truck_History"/> dependants from this <see cref="Manufacturer"/>
    /// </summary>
    public ICollection<Truck_History> TrucksHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="VehiculeModel"/> dependatns from this <see cref="Manufacturer"/>
    /// </summary>
    public ICollection<VehiculeModel> Models { get; set; } = [];

    #endregion
}
