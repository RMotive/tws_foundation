using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Trucks;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores information about certain manufacturers for <see cref="Trailer"/> and <see cref="Truck"/> data proccesses.
/// </summary>
public class Manufacturer
    : TWSEntity, IEntity_Name {

    #region Properties

    public string Name { get; set; } = default!;
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
