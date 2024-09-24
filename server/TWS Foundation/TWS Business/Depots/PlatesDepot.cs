using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Plate"/> dataDatabases entity mirror.
/// </summary>
public class PlatesDepot
    : BDepot<TWSBusinessDatabase, Plate> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Plate"/>.
    /// </summary>

    public PlatesDepot()
        : base(new(), null) {
    }
}
