using CSM_Foundation.Product;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Permit"/> based [Service] implementations.
/// </summary>
public interface IPermitsService
    : IService<Permit> {
}

/// <summary>
///     [Service] implementation for <see cref="Permit"/> based operations.
/// </summary>
public class PermitsService
    : BService<Permit, IPermitsDepot>, IPermitsService {

    /// <summary>
    ///     Creates a new <see cref="PermitsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Permit"/> based [Depot] handler to be used.
    /// </param>
    public PermitsService(IPermitsDepot Depot) : base(Depot) { }
}
