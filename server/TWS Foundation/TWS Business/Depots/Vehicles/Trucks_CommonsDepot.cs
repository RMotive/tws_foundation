using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Depots.Vehicles;

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Truck"/> dataDatabases entity mirror.
/// </summary>
public class Trucks_CommonsDepot 
    : BCommonDepot<Truck, TruckExternal, Truck_Common> {
    /// <summary>
    ///     Creates a new <see cref="Trucks_CommonsDepot"/> instance with custom handlers.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler.
    /// </param>
    /// <param name="Disposer">
    ///     Disposition manager handler.
    /// </param>
    public Trucks_CommonsDepot(Database Database, IDisposer? Disposer)
        : base(Database, Disposer) {
    }

    /// <summary>
    ///     Creates a new <see cref="Trucks_CommonsDepot"/> with default handlers.
    /// </summary>
    /// <remarks>
    ///     This constructor will generate a <see cref="BDepot{TDatabase, TEntity}"/> using the source database default constructor and no <see cref="IDisposer"/>.
    /// </remarks>
    public Trucks_CommonsDepot()
        : base(new Database(), null) {
    }
}
