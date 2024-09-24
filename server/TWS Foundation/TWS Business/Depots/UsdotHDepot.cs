using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="UsdotH"/> dataDatabases entity mirror.
/// </summary>
public class UsdotHDepot : BDepot<TWSBusinessDatabase, UsdotH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="UsdotH"/>.
    /// </summary>
    public UsdotHDepot() : base(new(), null) {
    }
}
