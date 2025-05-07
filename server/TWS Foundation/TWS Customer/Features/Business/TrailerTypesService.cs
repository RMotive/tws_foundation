using CSM_Foundation.Customer;

using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Customer.Features.Business;

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
    : BService<Trailer_Type, ITrailerTypesDepot>, ITrailerTypesService {

    /// <summary>
    ///     Creates a new instance of <see cref="TrailerTypesService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Trailer_Type"/> based [Depot] handler to be used.
    /// </param>
    public TrailerTypesService(ITrailerTypesDepot Depot) : base(Depot) { }
}
