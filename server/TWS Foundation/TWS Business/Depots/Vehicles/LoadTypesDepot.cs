using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Depots.Vehicles;

/// <summary>
///     [Interface] for <see cref="LoadType"/> based depot implementations.
/// </summary>
public interface ILoadTypesDepot
    : IDepot<LoadType> {
}

/// <summary>
///     [Depot] implementation for <see cref="LoadType"/> depot handler. 
/// </summary>
public class LoadTypesDepot
    : DepotBase<Database, LoadType>, ILoadTypesDepot {

    /// <summary>
    ///     Creates a new <see cref="LoadTypesDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public LoadTypesDepot(Database Database, IDisposer<IEntity>? Disposer) : base(Database, Disposer) { }
}
