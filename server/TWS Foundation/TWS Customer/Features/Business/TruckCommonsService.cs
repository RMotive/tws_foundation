using CSM_Foundation.Customer;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Truck_Common"/> based [Service] implementations.
/// </summary>
public interface ITrucksCommonService
    : IService<Truck_Common> {
}

/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class TruckCommonsService
    : BService<Truck_Common, ITrucksCommonsDepot>, ITrucksCommonService {

    /// <summary>
    ///     Creates a new instance of <see cref="TruckCommonsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Truck_Common"/> based [Depot] handler to be used.
    /// </param>
    public TruckCommonsService(ITrucksCommonsDepot Depot) : base(Depot) { }
}
