using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Depots;
using TWS_Business.Entities.Drivers;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Driver_Common"/> based [Service] implementations.
/// </summary>
public interface IDriversService
    : IService<Driver_Common> {
}

/// <summary>
///     [Service] native implementation for <see cref="Driver_Common"/> based operations.
/// </summary>
public class DriversService
    : BService<Driver_Common, IDriversCommonsDepot>, IDriversService {

    /// <summary>
    ///     Creates a new of <see cref="DriversService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Driver_Common"/> based <see cref="IDepot{TEntity}"/> handler to be used.
    /// </param>
    public DriversService(IDriversCommonsDepot Depot) : base(Depot) { }
}
