using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

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
    : BDepot<Database, Plate>, IPlatesDepot {

    /// <summary>
    ///     Creates a new <see cref="PlatesDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public PlatesDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }
}
