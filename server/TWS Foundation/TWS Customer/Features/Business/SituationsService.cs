using CSM_Foundation.Customer;

using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Situation"/> based [Service] implementations.
/// </summary>
public interface ISituationsService
    : IService<Situation> {
}

/// <summary>
///     [Service] for <see cref="Situation"/> based operations.
/// </summary>
public class SituationsService
    : BService<Situation, ISituationsDepot>, ISituationsService {

    /// <summary>
    ///     Creates a new instance of <see cref="SituationsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Situation"/> based [Depot] handler to be used.
    /// </param>
    public SituationsService(ISituationsDepot Depot) : base(Depot) { }
}
