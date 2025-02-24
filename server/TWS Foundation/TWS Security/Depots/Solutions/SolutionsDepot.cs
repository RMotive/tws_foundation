using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Security.Sets;

namespace TWS_Security.Depots.Solutions;

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Solution"/> dataDatabases entity mirror.
/// </summary>
public class SolutionsDepot
    : BDepot<TWSSecurityDatabase, Solution>, ISolutionsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Solution"/>.
    /// </summary>
    public SolutionsDepot(TWSSecurityDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    /// <summary>
    /// 
    /// </summary>
    public SolutionsDepot()
        : base(new(), null) {
    }
}
