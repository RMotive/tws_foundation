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
public class TrucksService
    : BService<Truck_Common, TrucksDepot>, ITrucksCommonService {

    /// <summary>
    ///     Creates a new instance of <see cref="TrucksService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Truck_Common"/> based [Depot] handler to be used.
    /// </param>
    public TrucksService(TrucksDepot Depot) : base(Depot) { }
}
