using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="DriverCommon"/> dataDatabases entity mirror.
/// </summary>
public class DriversCommonsDepot : BDepot<TWSBusinessDatabase, DriverCommon> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="DriverCommon"/>.
    /// </summary>
    public DriversCommonsDepot() : base(new(), null) {
    }
}
