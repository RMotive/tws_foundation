using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Status"/> dataDatabases entity mirror.
/// </summary>
public class StatusesDepot
: BDepot<BusinessDatabase, Status> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Status"/>.
    /// </summary>
    public StatusesDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public StatusesDepot() : base(new(), null) {
    }
}
