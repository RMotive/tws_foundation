using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckCommon"/> dataDatabases entity mirror.
/// </summary>
public class TrucksCommonsDepot : BDepot<TWSBusinessDatabase, TruckCommon> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckCommon"/>.
    /// </summary>
    public TrucksCommonsDepot() : base(new(), null) {
    }
}
