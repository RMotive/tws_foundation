using CSM_Foundation.Databases.Bases;
using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="DriverExternal"/> dataDatabases entity mirror.
/// </summary>
public class DriversExternalsDepot : BDatabaseDepot<TWSBusinessDatabase, DriverExternal> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="DriverExternal"/>.
    /// </summary>
    public DriversExternalsDepot() : base(new(), null) {
    }
}
