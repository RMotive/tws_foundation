using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Approach"/> dataDatabases entity mirror.
/// </summary>
public class ApproachesDepot : BDepot<TWSBusinessDatabase, Approach> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Approach"/>.
    /// </summary>
    public ApproachesDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public ApproachesDepot() : base(new(), null) {
    }
}
