using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Maintenances;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Maintenance"/> dataDatabases entity mirror.
/// </summary>
public class MaintenacesDepot
: BDepot<Database, Maintenance> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Maintenance"/>.
    /// </summary>
    public MaintenacesDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public MaintenacesDepot() : base(new(), null) {
    }
}
