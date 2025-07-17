using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Entities.Maintenances;

/// <summary>
///     [Interface] for <see cref="Maintenance"/> based [Depot] implementations.
/// </summary>
public interface IMaintenanceDepot
    : IDepot<Maintenance> {
}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Maintenance"/> dataDatabases entity mirror.
/// </summary>
public class MaintenacesDepot
: BDepot<Database, Maintenance>, IMaintenanceDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Maintenance"/>.
    /// </summary>
    public MaintenacesDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public MaintenacesDepot() : base(new(), null) {
    }
}
