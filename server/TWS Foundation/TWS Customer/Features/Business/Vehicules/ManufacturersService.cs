using CSM_Foundation.Customer;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="Manufacturer"/> based [Service] implementations.
/// </summary>
public interface IManufacturersService
    : IService<Manufacturer> {
}

/// <summary>
///     [Service] for <see cref="Manufacturer"/> based operations.
/// </summary>
public class ManufacturersService
    : BService<Manufacturer, IManufacturersDepot>, IManufacturersService {

    /// <summary>
    ///     Creates a new instance of <see cref="ManufacturersService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Manufacturer"/> based [Depot] handler to be used.
    /// </param>
    public ManufacturersService(IManufacturersDepot Depot) : base(Depot) { }
}
