using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Depots.Vehicles;


/// <summary>
///     [Depot] for <see cref="Truck_Common"/> based [Depot] implementations. 
/// </summary>
/// <remarks>
///     This is a shared depot to get <see cref="Truck"/> and <see cref="TruckExternal"/>.
/// </remarks>
public interface ITrucksCommonsDepot
    : IDepot<Truck_Common> {

}
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Truck"/> dataDatabases entity mirror.
/// </summary>
public class Trucks_CommonsDepot 
    : BCommonDepot<Database, Truck, TruckExternal, Truck_Common>, ITrucksCommonsDepot {
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
