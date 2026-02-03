using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

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
    : DepotBase<Database, Profile>, IProfilesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Profile"/>.
    /// </summary>
    public ProfilesDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
        : base(Databases, Disposer) {
    }
}