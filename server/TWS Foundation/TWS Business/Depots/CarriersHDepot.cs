using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="CarrierH"/> dataDatabases entity mirror.
/// </summary>
public class CarriersHDepot : BDepot<TWSBusinessDatabase, CarrierH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="CarrierH"/>.
    /// </summary>
    public CarriersHDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public CarriersHDepot() : base(new(), null) {
    }
}
