using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="DriverCommon"/> dataDatabases entity mirror.
/// </summary>
public class DriversCommonsDepot : BDepot<Database, DriverCommon> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="DriverCommon"/>.
    /// </summary>
    public DriversCommonsDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public DriversCommonsDepot() : base(new(), null) {
    }
}
