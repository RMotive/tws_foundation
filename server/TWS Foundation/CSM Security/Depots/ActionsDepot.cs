using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

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
    : DepotBase<Database, Action>, IActionsDepot {

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
    public ActionsDepot(Database Database, IDisposer<IEntity>? Disposer = null)
        : base(Database, Disposer) {
    }
}
