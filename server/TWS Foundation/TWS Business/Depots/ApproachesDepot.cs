using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Approach"/> dataDatabases entity mirror.
/// </summary>
public class ApproachesDepot 
    : BDepot<Database, Approach> {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Approach"/>.
    /// </summary>
    public ApproachesDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public ApproachesDepot() : base(new(), null) {
    }
}
