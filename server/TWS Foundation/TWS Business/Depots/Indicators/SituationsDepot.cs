using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots.Indicators;

/// <summary>
///     [Interface] for <see cref="Situation"/> based depot implementations.
/// </summary>
public interface ISituationsDepot
    : IDepot<Situation> {
}

/// <summary>
///     [Depot] that handles <see cref="Situation"/> operations.
/// </summary>
public class SituationsDepot
    : BDepot<Database, Situation>, ISituationsDepot {

    /// <summary>
    ///     Creates a new <see cref="SituationsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public SituationsDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }
}
