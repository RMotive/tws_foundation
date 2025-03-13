using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity;

using TWS_Business.Depots;
using TWS_Business.Entities.Drivers;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Driver"/> based [Service] implementations.
/// </summary>
public interface IDriversService
    : IService<Driver_Common> {
}

public class DriversService
    : BService<Driver_Common, IDriversDepot>, IDriversService {

    /// <summary>
    ///     Creates a new of <see cref="DriversService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Driver"/> based <see cref="IDepot{TEntity}"/> handler to be used.
    /// </param>
    public DriversService(IDriversDepot Depot) : base(Depot) { }
}
