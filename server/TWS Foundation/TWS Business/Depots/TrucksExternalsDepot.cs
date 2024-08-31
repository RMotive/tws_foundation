using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseSet{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckExternal"/> dataDatabases entity mirror.
/// </summary>
public class TrucksExternalsDepot : BDatabaseDepot<TWSBusinessDatabase, TruckExternal> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckExternal"/>.
    /// </summary>
    public TrucksExternalsDepot() : base(new(), null) {
    }
}
