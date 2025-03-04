using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Carrier_History"/> dataDatabases entity mirror.
/// </summary>
public class CarriersHDepot : BDepot<BusinessDatabase, Carrier_History> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Carrier_History"/>.
    /// </summary>
    public CarriersHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public CarriersHDepot() : base(new(), null) {
    }
}
