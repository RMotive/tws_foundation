using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TrailerCommon"/> dataDatabases entity mirror.
/// </summary>
public class TrailersCommonsDepot : BDatabaseDepot<TWSBusinessDatabase, TrailerCommon> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TrailerCommon"/>.
    /// </summary>
    public TrailersCommonsDepot() : base(new(), null) {
    }
}
