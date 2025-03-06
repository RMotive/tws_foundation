using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Trucks;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores information about the current situation for a business process entity.
/// </summary>
public class Situation
    : TWSEntity, IEntity_Name {

    #region Properties

    public string Name { get; set; } = default!;
    public string? Description { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="DriverCommon"/> dependants from this <see cref="Situation"/>
    /// </summary>
    public ICollection<DriverCommon> Drivers { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck_Common"/> dependants form this <see cref="Situation"/>.
    /// </summary>
    public ICollection<Truck_Common> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer_Common"/> dependants from this <see cref="Situation"/>.
    /// </summary>
    public ICollection<Trailer_Common> Trailers { get; set; } = [];

    #endregion
}
