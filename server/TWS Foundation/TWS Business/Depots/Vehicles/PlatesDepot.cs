using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Depots.Vehicles;

/// <summary>
///     [Interface] for <see cref="Plate"/> based [Depot] implementations.
/// </summary>
public interface IPlatesDepot
    : IDepot<Plate> {
}

/// <summary>
///     [Depot] implementation for <see cref="Plate"/> based entity operations.
/// </summary>
public class PlatesDepot
    : DepotBase<Database, Plate>, IPlatesDepot {

    /// <summary>
    ///     Creates a new <see cref="PlatesDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public PlatesDepot(Database Database, IDisposer<IEntity>? Disposer) : base(Database, Disposer) { }
}
