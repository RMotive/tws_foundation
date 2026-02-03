using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

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
public class TrailerTypesDepot : DepotBase<Database, Trailer_Type>, ITrailerTypesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer_Type"/>.
    /// </summary>
    public TrailerTypesDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailerTypesDepot() : base(new(), null) {
    }
}
