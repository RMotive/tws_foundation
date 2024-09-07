using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TrailerExternal"/> dataDatabases entity mirror.
/// </summary>
public class TrailersExternalsDepot : BDepot<TWSBusinessDatabase, TrailerExternal> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TrailerExternal"/>.
    /// </summary>
    public TrailersExternalsDepot() : base(new(), null) {
    }
}
