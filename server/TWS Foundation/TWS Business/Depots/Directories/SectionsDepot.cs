using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

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
    : DepotBase<Database, Section>, ISectionsDepot {

    /// <summary>
    ///     Creates a new <see cref="SectionsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used
    /// </param>
    public SectionsDepot(Database Database, IDisposer<IEntity>? Disposer) : base(Database, Disposer) { }
}
