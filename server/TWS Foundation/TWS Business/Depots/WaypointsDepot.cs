using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

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
    : DepotBase<Database, Waypoint>, IWaypointsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Waypoint"/>.
    /// </summary>
    public WaypointsDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
       : base(Databases, Disposer) {
    }
    public WaypointsDepot() : base(new(), null) {
    }
}
