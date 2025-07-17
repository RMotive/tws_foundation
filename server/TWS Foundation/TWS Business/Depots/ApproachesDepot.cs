using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

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
    : BDepot<Database, Approach>, IApproachesDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Approach"/>.
    /// </summary>
    public ApproachesDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public ApproachesDepot() : base(new(), null) {
    }
}
