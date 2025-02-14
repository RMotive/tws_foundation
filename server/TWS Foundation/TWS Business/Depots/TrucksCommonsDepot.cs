using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckCommon"/> dataDatabases entity mirror.
/// </summary>
public class TrucksCommonsDepot : BDepot<BusinessDatabase, TruckCommon> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckCommon"/>.
    /// </summary>
    public TrucksCommonsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrucksCommonsDepot() : base(new(), null) {
    }
}
