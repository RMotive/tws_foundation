using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="MaintenancesHDepot"/> dataDatabases entity mirror.
/// </summary>
public class MaintenancesHDepot
: BDepot<TWSBusinessDatabase, MaintenanceH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="MaintenancesHDepot"/>.
    /// </summary>
    public MaintenancesHDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public MaintenancesHDepot() : base(new(), null) {
    }
}
