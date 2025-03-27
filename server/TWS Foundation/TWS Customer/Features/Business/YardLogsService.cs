using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity;

using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="YardLog"/> based [Service] implementations. 
/// </summary>
public interface IYardLogsService
    : IService<YardLog> {
}

/// <summary>
///     [Service] native implementation for <see cref="YardLog"/> based operations.
/// </summary>
public class YardLogsService
    : BService<YardLog, IYardLogsDepot>, IYardLogsService {

    /// <summary>
    ///     Creates a new <see cref="YardLogsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="YardLog"/> based <see cref="IDepot{TEntity}"/> handler to be used
    /// </param>
    public YardLogsService(IYardLogsDepot Depot) : base(Depot) { }
}
