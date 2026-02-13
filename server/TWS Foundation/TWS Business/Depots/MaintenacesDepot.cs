using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities.Maintenances;

namespace TWS_Business.Depots;

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
: DepotBase<Database, Maintenance>, IMaintenanceDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Maintenance"/>.
    /// </summary>
    public MaintenacesDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
        : base(Databases, Disposer) {
    }
    public MaintenacesDepot() : base(new(), null) {
    }
}
