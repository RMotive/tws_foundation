using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Trailers;

/// <summary>
///     [Interface] for <see cref="Trailer_Class"/> based depot implementations.
/// </summary>
public interface ITrailerClassesDepot
    : IDepot<Trailer_Class> {

}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer_Class"/> dataDatabases entity mirror.
/// </summary>
public class TrailerClassesDepot : DepotBase<Database, Trailer_Class>, ITrailerClassesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer_Class"/>.
    /// </summary>
    public TrailerClassesDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailerClassesDepot() : base(new(), null) {
    }
}
