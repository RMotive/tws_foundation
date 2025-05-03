using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities;

namespace TWS_Business.Depots.Directories;

/// <summary>
///     [Interface] for <see cref="Section"/> based depot implementations.
/// </summary>
public interface ISectionsDepot
    : IDepot<Section> {
}

/// <summary>
///    [Depot] that handles <see cref="Section"/> operations.
/// </summary>
public class SectionsDepot
    : BDepot<Database, Section>, ISectionsDepot {

    /// <summary>
    ///     Creates a new <see cref="SectionsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used
    /// </param>
    public SectionsDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }
}
