using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="CarrierH"/> dataDatabases entity mirror.
/// </summary>
public class CarriersHDepot : BDatabaseDepot<TWSBusinessDatabase, CarrierH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="CarrierH"/>.
    /// </summary>
    public CarriersHDepot() : base(new(), null) {
    }
}
