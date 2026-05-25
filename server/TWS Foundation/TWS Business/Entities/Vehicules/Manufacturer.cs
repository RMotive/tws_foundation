using CSM_Database_Core.Core.Attributes;

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
    [EntityDependency("TrucksHistories", typeof(Truck_History), isCollection:true)]
    public ICollection<Truck_History> TrucksHistories { get; set; } = [];

    /// <summary>
    ///     <see cref="VehiculeModel"/> dependatns from this <see cref="Manufacturer"/>
    /// </summary>
    [EntityDependency("Models", typeof(VehiculeModel), isCollection:true)]
    public ICollection<VehiculeModel> Models { get; set; } = [];

    #endregion
}
