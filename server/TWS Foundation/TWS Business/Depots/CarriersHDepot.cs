using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="CarrierH"/> dataDatabases entity mirror.
/// </summary>
public class CarriersHDepot : BDepot<BusinessDatabase, CarrierH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="CarrierH"/>.
    /// </summary>
    public CarriersHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public CarriersHDepot() : base(new(), null) {
    }
}
