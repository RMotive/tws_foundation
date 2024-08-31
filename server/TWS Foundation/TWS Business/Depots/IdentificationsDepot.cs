using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Identification"/> dataDatabases entity mirror.
/// </summary>
public class IdentificationsDepot : BDatabaseDepot<TWSBusinessDatabase, Identification> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Axis"/>.
    /// </summary>
    public IdentificationsDepot() : base(new(), null) {
    }
}
