using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Driver"/> dataDatabases entity mirror.
/// </summary>
public class DriversDepot : BDepot<Database, Driver> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Driver"/>.
    /// </summary>
    public DriversDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public DriversDepot() : base(new(), null) {
    }
}
