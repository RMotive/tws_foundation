using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Depots.Vehicles;

/// <summary>
///     [Interface] for <see cref="Truck"/> based [Depot] implementations.
/// </summary>
public interface ITrucksDepot
    : IDepot<Truck> {
}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Truck"/> dataDatabases entity mirror.
/// </summary>
public class TrucksDepot 
    : BDepot<Database, Truck>, ITrucksDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Truck"/>.
    /// </summary>
    public TrucksDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrucksDepot()
        : base(new(), null) {
    }
}
