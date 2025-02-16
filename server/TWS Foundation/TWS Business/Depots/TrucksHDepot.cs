using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckH"/> dataDatabases entity mirror.
/// </summary>
public class TrucksHDepot
: BDepot<BusinessDatabase, TruckH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckH"/>.
    /// </summary>
    public TrucksHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrucksHDepot() : base(new(), null) {
    }
}
