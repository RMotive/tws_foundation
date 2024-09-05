using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Driver"/> dataDatabases entity mirror.
/// </summary>
public class DriversDepot : BDatabaseDepot<TWSBusinessDatabase, Driver> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Driver"/>.
    /// </summary>
    public DriversDepot() : base(new(), null) {
    }
}
