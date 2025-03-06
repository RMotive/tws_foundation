using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Carriers;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Carrier"/> dataDatabases entity mirror.
/// </summary>
public class CarriersDepot : BDepot<BusinessDatabase, Carrier> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Carrier"/>.
    /// </summary>
    public CarriersDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public CarriersDepot() : base(new(), null) {
    }
}
