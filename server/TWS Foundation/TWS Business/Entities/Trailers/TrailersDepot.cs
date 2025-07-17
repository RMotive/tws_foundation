using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Depots.Bases;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Trailers;


/// <summary>
///     [Depot] for <see cref="Trailer_Common"/> based [Depot] implementations. 
/// </summary>
/// <remarks>
///     This is a shared depot to get <see cref="Trailer"/> and <see cref="TrailerExternal"/>.
/// </remarks>
public interface ITrailersDepot
    : IDepot<Trailer_Common> {

}
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer"/> dataDatabases entity mirror.
/// </summary>
public class TrailersDepot
    : BCommonDepot<Database, Trailer, TrailerExternal, Trailer_Common>, ITrailersDepot {
    /// <summary>
    ///     Creates a new <see cref="TrailersDepot"/> instance with custom handlers.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler.
    /// </param>
    /// <param name="Disposer">
    ///     Disposition manager handler.
    /// </param>
    public TrailersDepot(Database Database, IDisposer? Disposer)
        : base(Database, Disposer) {
    }

    /// <summary>
    ///     Creates a new <see cref="TrailersDepot"/> with default handlers.
    /// </summary>
    /// <remarks>
    ///     This constructor will generate a <see cref="BDepot{TDatabase, TEntity}"/> using the source database default constructor and no <see cref="IDisposer"/>.
    /// </remarks>
    public TrailersDepot()
        : base(new Database(), null) {
    }
}
