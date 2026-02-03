using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Depots.Bases;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Depots.Vehicles;


/// <summary>
///     [Depot] for <see cref="Truck_Common"/> based [Depot] implementations. 
/// </summary>
/// <remarks>
///     This is a shared depot to get <see cref="Truck"/> and <see cref="TruckExternal"/>.
/// </remarks>
public interface ITrucksDepot
    : IDepot<Truck_Common> {
}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Truck"/> dataDatabases entity mirror.
/// </summary>
public class TrucksDepot
    : BCommonDepot<Database, Truck, TruckExternal, Truck_Common>, ITrucksDepot {
    /// <summary>
    ///     Creates a new <see cref="TrucksDepot"/> instance with custom handlers.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler.
    /// </param>
    /// <param name="Disposer">
    ///     Disposition manager handler.
    /// </param>
    public TrucksDepot(Database Database, IDisposer<IEntity>? Disposer)
        : base(Database, Disposer) {
    }

    /// <summary>
    ///     Creates a new <see cref="TrucksDepot"/> with default handlers.
    /// </summary>
    /// <remarks>
    ///     This constructor will generate a <see cref="BDepot{TDatabase, TEntity}"/> using the source database default constructor and no <see cref="IDisposer"/>.
    /// </remarks>
    public TrucksDepot()
        : base(new Database(), null) {
    }
}
