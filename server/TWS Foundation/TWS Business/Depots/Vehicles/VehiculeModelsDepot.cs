using CSM_Foundation.Database.Entity;

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
    : BDepot<Database, VehiculeModel>, IVehiculesModelsDepot {

    /// <summary>
    ///     Creates a new <see cref="VehiculeModelsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public VehiculeModelsDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }
}
