using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots.Indicators;

/// <summary>
///     [Interface] for <see cref="Status"/> based depot implementations.
/// </summary>
public interface IStatusesDepot
    : IDepot<Status> {

}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Status"/> dataDatabases entity mirror.
/// </summary>
public class StatusesDepot
    : DepotBase<Database, Status>, IStatusesDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Status"/>.
    /// </summary>
    public StatusesDepot(Database Databases, IDisposer<IEntity>? Disposer = null) : base(Databases, Disposer) { }
}
