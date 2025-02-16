using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities;

namespace TWS_Customer.Services.Interfaces;
public interface IVehiculesModelsService {
    Task<SetViewOut<VehiculeModel>> View(SetViewOptions<VehiculeModel> Options);

    Task<VehiculeModel> Create(VehiculeModel vehiculeModel);
}
