using CSM_Foundation.Customer;

using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Truck_Common"/> based [Service] implementations.
/// </summary>
public interface ITrailersService
    : IService<Trailer_Common> {
}

/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class TrailersService
    : BService<Trailer_Common, TrailersDepot>, ITrailersService {

    /// <summary>
    ///     Creates a new instance of <see cref="TrailersService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Truck_Common"/> based [Depot] handler to be used.
    /// </param>
    public TrailersService(TrailersDepot Depot) : base(Depot) { }
}
