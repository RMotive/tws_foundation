using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;

/// <summary>
///     [Interface] for <see cref="Approach"/> based [Depot] implementations.
/// </summary>
public interface IApproachesDepot
    : IDepot<Approach> {
}

/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Approach"/> dataDatabases entity mirror.
/// </summary>
public class ApproachesDepot
    : DepotBase<Database, Approach>, IApproachesDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Approach"/>.
    /// </summary>
    public ApproachesDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
       : base(Databases, Disposer) {
    }
    public ApproachesDepot() : base(new(), null) {
    }
}
