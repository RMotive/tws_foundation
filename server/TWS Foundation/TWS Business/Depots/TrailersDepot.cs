using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer"/> dataDatabases entity mirror.
/// </summary>
public class TrailersDepot : BDepot<TWSBusinessDatabase, Trailer> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer"/>.
    /// </summary>
    public TrailersDepot() : base(new(), null) {
    }
}
