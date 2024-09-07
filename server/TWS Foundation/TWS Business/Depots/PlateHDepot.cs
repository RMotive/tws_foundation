using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="PlatesHDepot"/> dataDatabases entity mirror.
/// </summary>
public class PlatesHDepot
: BDepot<TWSBusinessDatabase, PlateH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="PlatesHDepot"/>.
    /// </summary>
    public PlatesHDepot() : base(new(), null) {
    }
}
