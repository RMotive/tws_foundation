using CSM_Foundation.Database.Entity.Depot;
using TWS_Business.Entities;
using CSM_Foundation.Database;

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
    : BDepot<Database, Resource>, IResourcesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Resource"/>.
    /// </summary>
    public ResourcesDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public ResourcesDepot() : base(new(), null) {
    }
}
