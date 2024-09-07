using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Status"/> dataDatabases entity mirror.
/// </summary>
public class StatusesDepot
: BDepot<TWSBusinessDatabase, Status> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Status"/>.
    /// </summary>
    public StatusesDepot() : base(new(), null) {
    }
}
