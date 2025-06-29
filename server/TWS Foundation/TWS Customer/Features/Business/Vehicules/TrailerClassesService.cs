using CSM_Foundation.Customer;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
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
    : BService<Trailer_Class, ITrailerClassesDepot>, ITrailerClassesService {

    /// <summary>
    ///     Creates a new instance of <see cref="TrailerclasssService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Trailer_Class"/> based [Depot] handler to be used.
    /// </param>
    public TrailerClassesService(ITrailerClassesDepot Depot) : base(Depot) { }
}
