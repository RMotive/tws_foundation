using CSM_Foundation.Customer;

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
    : BService<Location, ILocationsDepot>, ILocationsService {

    /// <summary>
    ///     Creates a new instance of <see cref="LocationsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Location"/> based [Depot] handler to be used.
    /// </param>
    public LocationsService(ILocationsDepot Depot) : base(Depot) { }
}
