using CSM_Foundation.Database.Entity;

using CSM_Security;

namespace CSM_Security.Entities.Solutions;

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Solution"/> dataDatabases entity mirror.
/// </summary>
public class SolutionsDepot
    : BDepot<Database, Solution>, ISolutionsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Solution"/>.
    /// </summary>
    public SolutionsDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    /// <summary>
    /// 
    /// </summary>
    public SolutionsDepot()
        : base(new(), null) {
    }
}
