using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="UsdotH"/> dataDatabases entity mirror.
/// </summary>
public class UsdotHDepot : BDatabaseDepot<TWSBusinessDatabase, UsdotH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="UsdotH"/>.
    /// </summary>
    public UsdotHDepot() : base(new(), null) {
    }
}
