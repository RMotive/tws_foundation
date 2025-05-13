using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

namespace CSM_Security.Depots;

/// <summary>
///     [Depot] that provides operations for <see cref="Entities.Action"/> entity.
/// </summary>
public class ActionsDepot
    : BDepot<Database, Entities.Action> {

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
