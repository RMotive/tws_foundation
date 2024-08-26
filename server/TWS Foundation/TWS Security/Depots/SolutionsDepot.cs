using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;

using TWS_Security.Sets;

namespace TWS_Security.Depots;

/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Solution"/> dataDatabases entity mirror.
/// </summary>
public class SolutionsDepot
    : BDatabaseDepot<TWSSecurityDatabases, Solution> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Solution"/>.
    /// </summary>
    public SolutionsDepot(TWSSecurityDatabases Databases, IMigrationDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    /// <summary>
    /// 
    /// </summary>
    public SolutionsDepot()
        : base(new(), null) {

    }
}
