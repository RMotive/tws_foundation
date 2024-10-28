
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Truck"/> dataDatabases entity mirror.
/// </summary>
public class TruckDepot : BDepot<TWSBusinessDatabase, Truck> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Truck"/>.
    /// </summary>
    public TruckDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TruckDepot()
        : base(new(), null) {
    }
}
