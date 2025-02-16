using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="MaintenancesHDepot"/> dataDatabases entity mirror.
/// </summary>
public class MaintenancesHDepot
: BDepot<BusinessDatabase, MaintenanceH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="MaintenancesHDepot"/>.
    /// </summary>
    public MaintenancesHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public MaintenancesHDepot() : base(new(), null) {
    }
}
