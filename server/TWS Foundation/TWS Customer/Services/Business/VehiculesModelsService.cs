using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class VehiculeModelService : IVehiculesModelsService {
    private readonly VehiculesModelsDepot VehiculesModels;

    public VehiculeModelService(VehiculesModelsDepot vehiculeModel) {
        VehiculesModels = vehiculeModel;
    }

    public async Task<SetViewOut<VehiculeModel>> View(SetViewOptions<VehiculeModel> Options) {
        return await VehiculesModels.View(Options);
    }

    public async Task<VehiculeModel> Create(VehiculeModel vehiculeModel) {
        return await VehiculesModels.Create(vehiculeModel);
    }
}
