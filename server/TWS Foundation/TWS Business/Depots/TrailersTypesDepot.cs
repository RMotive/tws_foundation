using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TrailerType"/> dataDatabases entity mirror.
/// </summary>
public class TrailersTypesDepot : BDepot<TWSBusinessDatabase, TrailerType> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TrailerType"/>.
    /// </summary>
    public TrailersTypesDepot() : base(new(), null) {
    }
}
