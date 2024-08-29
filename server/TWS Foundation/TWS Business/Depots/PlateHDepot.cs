using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="PlatesHDepot"/> dataDatabases entity mirror.
/// </summary>
public class PlatesHDepot
: BDatabaseDepot<TWSBusinessDatabase, PlateH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="PlatesHDepot"/>.
    /// </summary>
    public PlatesHDepot() : base(new(), null) {
    }
}
