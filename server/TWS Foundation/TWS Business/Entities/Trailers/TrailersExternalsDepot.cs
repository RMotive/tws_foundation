using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Trailers;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TrailerExternal"/> dataDatabases entity mirror.
/// </summary>
public class TrailersExternalsDepot : BDepot<Database, TrailerExternal> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TrailerExternal"/>.
    /// </summary>
    public TrailersExternalsDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailersExternalsDepot() : base(new(), null) {
    }
}
