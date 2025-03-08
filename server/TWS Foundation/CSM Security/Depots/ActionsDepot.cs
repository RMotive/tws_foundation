using CSM_Foundation.Database.Entity;

namespace CSM_Security.Depots;

/// <summary>
///     [Depot] that provides operations for <see cref="Entities.Action"/> entity.
/// </summary>
public class ActionsDepot
    : BDepot<Database, Entities.Action> {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Database">
    ///     Database context handler.
    /// </param>
    /// <param name="Disposer">
    ///     
    /// </param>
    public ActionsDepot(Database Database, IDisposer? Disposer) 
        : base(Database, Disposer) {
    }
}
