using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Trailers;


/// <summary>
///     [Interface] for <see cref="Trailer"/> based [Depot] implementations.
/// </summary>
public interface ITrailersDepot
    : IDepot<Trailer> {
}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer"/> dataDatabases entity mirror.
/// </summary>
public class TrailersDepot : BDepot<Database, Trailer>, ITrailersDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer"/>.
    /// </summary>
    public TrailersDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailersDepot() : base(new(), null) {
    }
}
