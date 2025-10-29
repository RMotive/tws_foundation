using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using CSM_Security.Entities;

namespace CSM_Security.Depots;

/// <summary>
///     [Interface] for [PermitsDepot] implementations.
/// </summary>
public interface IPermitsDepot
    : IDepot<Permit> {
}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Solution"/> dataDatabases entity mirror.
/// </summary>
public class PermitsDepot
    : BDepot<Database, Permit>, IPermitsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Permit"/>.
    /// </summary>
    public PermitsDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
}