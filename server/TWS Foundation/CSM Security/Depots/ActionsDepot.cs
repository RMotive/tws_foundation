using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

using Action = CSM_Security.Entities.Action;

namespace CSM_Security.Depots;

/// <summary>
///     [Interface] for [PermitsDepot] implementations.
/// </summary>
public interface IActionsDepot
    : IDepot<Action> {
}


/// <summary>
///     [Depot] that provides operations for <see cref= Action"/> entity.
/// </summary>
public class ActionsDepot
    : BDepot<Database, Action>, IActionsDepot {

    /// <summary>
    ///     Creates a new <see cref="ActionsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition manager handler to be used.
    /// </param>
    /// <remarks>
    ///     If no <paramref name="Database"/> is provided, a default configured instance will be used. 
    ///     If no <paramref name="Disposer"/> is provided, none will be used.
    /// </remarks>
    public ActionsDepot(Database Database, IDisposer? Disposer = null)
        : base(Database, Disposer) {
    }
}
