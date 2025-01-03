using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Waypoint"/> dataDatabases entity mirror.
/// </summary>
public class WaypointsDepot : BDepot<TWSBusinessDatabase, Waypoint> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Waypoint"/>.
    /// </summary>
    public WaypointsDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public WaypointsDepot() : base(new(), null) {
    }
}
