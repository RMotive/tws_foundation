using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Identification"/> dataDatabases entity mirror.
/// </summary>
public class IdentificationsDepot : BDepot<Database, Identification> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Axis"/>.
    /// </summary>
    public IdentificationsDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public IdentificationsDepot() : base(new(), null) {
    }
}
