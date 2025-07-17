using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;

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
    : BDepot<Database, LoadType>, ILoadTypesDepot {

    /// <summary>
    ///     Creates a new <see cref="LoadTypesDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public LoadTypesDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }
}
