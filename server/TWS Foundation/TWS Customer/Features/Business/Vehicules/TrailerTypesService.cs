using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Depots.Vehicles.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="Trailer_Type"/> based [Service] implementations.
/// </summary>
public interface ITrailerTypesService
    : IService<Trailer_Type> {
}

/// <summary>
///     [Service] for <see cref="Trailer_Type"/> based operations.
/// </summary>
public class TrailerTypesService
    : BService<Trailer_Type, TrailerTypesDepot>, ITrailerTypesService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="TrailerTypesService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Trailer_Type"/> based [Depot] handler to be used.
    /// </param>
    public TrailerTypesService(TrailerTypesDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }

}
