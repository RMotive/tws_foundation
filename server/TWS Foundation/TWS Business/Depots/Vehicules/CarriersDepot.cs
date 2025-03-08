using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Depots.Vehicules;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Carrier"/> dataDatabases entity mirror.
/// </summary>
public class CarriersDepot : BDepot<Database, Carrier> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Carrier"/>.
    /// </summary>
    public CarriersDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public CarriersDepot() : base(new(), null) {
    }
}
