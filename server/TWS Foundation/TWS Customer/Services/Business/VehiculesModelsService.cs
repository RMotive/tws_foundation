using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class VehiculeModelService : IVehiculesModelsService {
    private readonly VehiculesModelsDepot VehiculesModels;

    public VehiculeModelService(VehiculesModelsDepot vehiculeModel) {
        VehiculesModels = vehiculeModel;
    }

    private IQueryable<VehiculeModel> Include(IQueryable<VehiculeModel> query) {
        return query
            .Include(t => t.ManufacturerNavigation)
            .Include(t => t.StatusNavigation);
    }

    public async Task<SetViewOut<VehiculeModel>> View(SetViewOptions<VehiculeModel> Options) {
        return await VehiculesModels.View(Options, Include);
    }

    public async Task<VehiculeModel> Create(VehiculeModel vehiculeModel) {
        return await VehiculesModels.Create(vehiculeModel);
    }
}
