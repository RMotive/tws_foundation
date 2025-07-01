using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity;
using TWS_Business.Entities;

namespace TWS_Business.Depots;


/// <summary>
///     [Interface] for <see cref="Waypoint"/> based depot implementations.
/// </summary>
public interface IWaypointsDepot
    : IDepot<Waypoint> {

}
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Waypoint"/> dataDatabases entity mirror.
/// </summary>
public class WaypointsDepot
    : BDepot<Database, Waypoint>, IWaypointsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Waypoint"/>.
    /// </summary>
    public WaypointsDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public WaypointsDepot() : base(new(), null) {
    }
}
