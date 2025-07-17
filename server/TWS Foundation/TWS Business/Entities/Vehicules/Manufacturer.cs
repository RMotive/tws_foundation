using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using BNamedEntity = TWS_Business.Bases.BNamedEntity;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [Entity] that stores information about certain manufacturers for <see cref="Trailer"/> and <see cref="Truck"/> data proccesses.
/// </summary>
public class Manufacturer
    : BNamedEntity {

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
