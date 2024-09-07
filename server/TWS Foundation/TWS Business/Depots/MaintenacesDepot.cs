using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Maintenance"/> dataDatabases entity mirror.
/// </summary>
public class MaintenacesDepot
: BDepot<TWSBusinessDatabase, Maintenance> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Maintenance"/>.
    /// </summary>
    public MaintenacesDepot() : base(new(), null) {
    }
}
