using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using CSM_Security.Entities;

namespace CSM_Security.Depots;


/// <summary>
///     [Interface] for <see cref="Feature"/> based [Depot] implementations.
/// </summary>
public interface IFeaturesDepot
    : IDepot<Feature> {
}

/// <summary>
///     [Depot] for <see cref="Feature"/> entity operations.
/// </summary>
public class FeaturesDepot
    : DepotBase<Database, Feature>, IFeaturesDepot {

    /// <summary>
    ///     Creates a new <see cref="FeaturesDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public FeaturesDepot(Database Database, IDisposer<IEntity>? Disposer) : base(Database, Disposer) { }
}
