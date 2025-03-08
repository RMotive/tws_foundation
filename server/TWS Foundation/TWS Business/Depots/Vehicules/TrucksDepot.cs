using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Depots.Vehicules;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Truck"/> dataDatabases entity mirror.
/// </summary>
public class TrucksDepot 
    : BDepot<Database, Truck> {
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
