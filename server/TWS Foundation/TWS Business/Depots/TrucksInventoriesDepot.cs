using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckInventory"/> dataDatabases entity mirror.
/// </summary>
public class TrucksInventoriesDepot : BDepot<BusinessDatabase, TruckInventory> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckInventory"/>.
    /// </summary>
    public TrucksInventoriesDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrucksInventoriesDepot() : base(new(), null) {
    }
}
