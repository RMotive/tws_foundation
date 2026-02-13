using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Depots.Vehicles.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="Trailer_Class"/> based [Service] implementations.
/// </summary>
public interface ITrailerClassesService
    : IService<Trailer_Class> {
}

/// <summary>
///     [Service] for <see cref="Trailer_Class"/> based operations.
/// </summary>
/// </summary>
public class TrailerClassesService
    : BService<Trailer_Class, TrailerClassesDepot>, ITrailerClassesService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="TrailerclasssService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Trailer_Class"/> based [Depot] handler to be used.
    /// </param>
    public TrailerClassesService(TrailerClassesDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }
}
