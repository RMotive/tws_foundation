using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Location"/> dataDatabases entity mirror.
/// </summary>
public class LocationsDepot : BDepot<TWSBusinessDatabase, Location> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Location"/>.
    /// </summary>
    public LocationsDepot() : base(new(), null) {
    }
}
