using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Depots.Vehicles;

/// <summary>
///     [Interface] for <see cref="VehiculeModel"/> based depot implementations.
/// </summary>
public interface IVehiculesModelsDepot
    : IDepot<VehiculeModel> {
}


/// <summary>
///     [Depot] implementation for <see cref="VehiculeModel"/> entities operations.
/// </summary>
public class VehiculeModelsDepot
    : DepotBase<Database, VehiculeModel>, IVehiculesModelsDepot {

    /// <summary>
    ///     Creates a new <see cref="VehiculeModelsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public VehiculeModelsDepot(Database Database, IDisposer<IEntity>? Disposer) : base(Database, Disposer) { }
}
