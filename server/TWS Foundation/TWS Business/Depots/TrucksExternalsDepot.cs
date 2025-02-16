using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseSet{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckExternal"/> dataDatabases entity mirror.
/// </summary>
public class TrucksExternalsDepot : BDepot<BusinessDatabase, TruckExternal> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckExternal"/>.
    /// </summary>
    public TrucksExternalsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrucksExternalsDepot() : base(new(), null) {
    }
}
