

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class LoadTypesService : ILoadTypesService {
    private readonly LoadTypesDepot LoadTypes;

    public LoadTypesService(LoadTypesDepot loadTypes) {
        LoadTypes = loadTypes;
    }

    public async Task<SetViewOut<LoadType>> View(SetViewOptions<LoadType> Options) {
        return await LoadTypes.View(Options);
    }
}
