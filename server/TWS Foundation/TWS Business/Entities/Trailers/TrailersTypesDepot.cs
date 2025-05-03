using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Trailers;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer_Type"/> dataDatabases entity mirror.
/// </summary>
public class TrailersTypesDepot : BDepot<Database, Trailer_Type> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer_Type"/>.
    /// </summary>
    public TrailersTypesDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailersTypesDepot() : base(new(), null) {
    }
}
