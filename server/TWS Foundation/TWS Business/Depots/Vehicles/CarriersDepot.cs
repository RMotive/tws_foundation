using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Depots.Vehicles;

/// <summary>
///     [interface] for <see cref="Carrier"/> based [Depot] implementations.
/// </summary>
public interface ICarriersDepot
    : IDepot<Carrier> {
}

/// <summary>
///     [Depot] implementation for <see cref="Carrier"/> based entity operations.
/// </summary>
public class CarriersDepot
    : DepotBase<Database, Carrier>, ICarriersDepot {

    /// <summary>
    ///     Creates a new <see cref="CarriersDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public CarriersDepot(Database Database, IDisposer<IEntity>? Disposer) : base(Database, Disposer) { }

}
