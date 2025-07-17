using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Depots.Vehicles;

/// <summary>
///     [Interface] for <see cref="Manufacturer"/> based [Depots] implementations.
/// </summary>
public interface IManufacturersDepot
    : IDepot<Manufacturer> {
}


/// <summary>
///     [Depot] for <see cref="Manufacturer"/> entities.
/// </summary>
public class ManufacturersDepot
    : BDepot<Database, Manufacturer>, IManufacturersDepot {

    /// <summary>
    ///     Creates a new <see cref="ManufacturersDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public ManufacturersDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }
}
