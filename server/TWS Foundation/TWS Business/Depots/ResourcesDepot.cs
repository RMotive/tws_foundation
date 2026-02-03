using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;


/// <summary>
///     [Interface] for <see cref="Resource"/> based depot implementations.
/// </summary>
public interface IResourcesDepot
    : IDepot<Resource> {

}
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Resource"/> dataDatabases entity mirror.
/// </summary>
public class ResourcesDepot
    : DepotBase<Database, Resource>, IResourcesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Resource"/>.
    /// </summary>
    public ResourcesDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
       : base(Databases, Disposer) {
    }
    public ResourcesDepot() : base(new(), null) {
    }
}
