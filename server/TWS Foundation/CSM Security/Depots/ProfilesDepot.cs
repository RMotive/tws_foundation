using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using CSM_Security.Entities;

namespace CSM_Security.Depots;

/// <summary>
///     [Interface] for [ProfilesDepot] implementations.
/// </summary>
public interface IProfilesDepot
    : IDepot<Profile> {
}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Profile"/> dataDatabases entity mirror.
/// </summary>
public class ProfilesDepot
    : BDepot<Database, Profile>, IProfilesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Profile"/>.
    /// </summary>
    public ProfilesDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
}