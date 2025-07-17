using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Trailers;

/// <summary>
///     [Interface] for <see cref="Trailer_Type"/> based depot implementations.
/// </summary>
public interface ITrailerTypesDepot
    : IDepot<Trailer_Type> {

}

/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer_Type"/> dataDatabases entity mirror.
/// </summary>
public class TrailerTypesDepot : BDepot<Database, Trailer_Type>, ITrailerTypesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer_Type"/>.
    /// </summary>
    public TrailerTypesDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailerTypesDepot() : base(new(), null) {
    }
}
