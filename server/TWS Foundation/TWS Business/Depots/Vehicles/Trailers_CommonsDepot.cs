using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Depots.Bases;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Depots.Vehicles;


/// <summary>
///     [Depot] for <see cref="Trailer_Common"/> based [Depot] implementations. 
/// </summary>
/// <remarks>
///     This is a shared depot to get <see cref="Truck"/> and <see cref="TruckExternal"/>.
/// </remarks>
public interface ITrailersCommonsDepot
    : IDepot<Trailer_Common> {

}
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer"/> dataDatabases entity mirror.
/// </summary>
public class Trailers_CommonsDepot
    : BCommonDepot<Database, Trailer, TrailerExternal, Trailer_Common>, ITrailersCommonsDepot {
    /// <summary>
    ///     Creates a new <see cref="Trailers_CommonsDepot"/> instance with custom handlers.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler.
    /// </param>
    /// <param name="Disposer">
    ///     Disposition manager handler.
    /// </param>
    public Trailers_CommonsDepot(Database Database, IDisposer? Disposer)
        : base(Database, Disposer) {
    }

    /// <summary>
    ///     Creates a new <see cref="Trailers_CommonsDepot"/> with default handlers.
    /// </summary>
    /// <remarks>
    ///     This constructor will generate a <see cref="BDepot{TDatabase, TEntity}"/> using the source database default constructor and no <see cref="IDisposer"/>.
    /// </remarks>
    public Trailers_CommonsDepot()
        : base(new Database(), null) {
    }
}
