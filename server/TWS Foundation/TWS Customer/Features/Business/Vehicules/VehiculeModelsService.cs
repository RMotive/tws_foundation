using CSM_Database_Core.Core.Errors;
using CSM_Database_Core.Depots.Models;

using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="VehiculeModel"/> based [Service] implementations.
/// </summary>
public interface IVehiculeModelsService
    : IService<VehiculeModel> {
}

/// <summary>
///     [Service] for <see cref="VehiculeModel"/> based operations.
/// </summary>
public class VehiculeModelsService
    : BService<VehiculeModel, VehiculeModelsDepot>, IVehiculeModelsService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="VehiculeModelsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="VehiculeModel"/> based [Depot] handler to be used.
    /// </param>
    public VehiculeModelsService(VehiculeModelsDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }

}
