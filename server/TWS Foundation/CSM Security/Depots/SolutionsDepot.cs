using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using CSM_Security.Entities;

namespace CSM_Security.Depots;

/// <summary>
///     [Interface] for [SolutionsDepot] implementations.
/// </summary>
public interface ISolutionsDepot
    : IDepot<Solution> {
}

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
}

