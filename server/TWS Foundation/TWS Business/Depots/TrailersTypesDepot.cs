using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TrailerType"/> dataDatabases entity mirror.
/// </summary>
public class TrailersTypesDepot : BDepot<BusinessDatabase, TrailerType> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TrailerType"/>.
    /// </summary>
    public TrailersTypesDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailersTypesDepot() : base(new(), null) {
    }
}
