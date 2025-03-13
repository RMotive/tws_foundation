using CSM_Foundation.Customer;

using TWS_Business.Depots.Vehicules;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Carrier"/> based [Service] implementations.
/// </summary>
public interface ICarriersService
    : IService<Carrier> {
}

/// <summary>
///     [Service] for <see cref="Carrier"/> based operations.
/// </summary>
public class CarriersService
    : BService<Carrier, ICarriersDepot>, ICarriersService {

    /// <summary>
    ///     Creates a new instance of <see cref="CarriersService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Carrier"/> based [Depot] handler to be used.
    /// </param>
    public CarriersService(ICarriersDepot Depot) : base(Depot) { }
}
