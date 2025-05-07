using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;

/// <summary>
///     [Interface] for <see cref="Location"/> based depot implementations.
/// </summary>
public interface ILocationsDepot
    : IDepot<Location> {

}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Location"/> dataDatabases entity mirror.
/// </summary>
public class LocationsDepot
    : BDepot<Database, Location>, ILocationsDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Location"/>.
    /// </summary>
    public LocationsDepot(Database Databases, IDisposer? Disposer = null) : base(Databases, Disposer) { }

    public LocationsDepot() : base(new(), null) {
    }
}
