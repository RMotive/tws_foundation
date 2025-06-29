using CSM_Foundation.Customer;

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
    : BService<VehiculeModel, IVehiculesModelsDepot>, IVehiculeModelsService {

    /// <summary>
    ///     Creates a new instance of <see cref="VehiculeModelsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="VehiculeModel"/> based [Depot] handler to be used.
    /// </param>
    public VehiculeModelsService(IVehiculesModelsDepot Depot) : base(Depot) { }
}
