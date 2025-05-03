using CSM_Foundation.Database.Entity;

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
    : BDepot<Database, Status>, IStatusesDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Status"/>.
    /// </summary>
    public StatusesDepot(Database Databases, IDisposer? Disposer = null) : base(Databases, Disposer) { }
}
