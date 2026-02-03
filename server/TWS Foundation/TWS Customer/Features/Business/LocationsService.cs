using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Location"/> based [Service] implementations.
/// </summary>
public interface ILocationsService
    : IService<Location> {
}

/// <summary>
///     [Service] for <see cref="Location"/> based operations.
/// </summary>
public class LocationsService
    : BService<Location, LocationsDepot>, ILocationsService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="LocationsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Location"/> based [Depot] handler to be used.
    /// </param>
    public LocationsService(LocationsDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }
}
