using CSM_Foundation.Product;

using CSM_Security.Depots;

using Action = CSM_Security.Entities.Action;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Action"/> based [Service] implementations.
/// </summary>
public interface IActionsService
    : IService<Action> {
}

/// <summary>
///     [Service] implementation for <see cref="Action"/> based operations.
/// </summary>
public class ActionsService
    : BService<Action, IActionsDepot>, IActionsService {

    /// <summary>
    ///     Creates a new <see cref="ActionsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Action"/> based [Depot] handler to be used.
    /// </param>
    public ActionsService(IActionsDepot Depot) : base(Depot) { }
}
