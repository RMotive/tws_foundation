
using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Truck"/> dataDatabases entity mirror.
/// </summary>
public class TruckDepot : BDatabaseDepot<TWSBusinessDatabase, Truck> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Truck"/>.
    /// </summary>
    public TruckDepot()
        : base(new(), null) {
    }
}
