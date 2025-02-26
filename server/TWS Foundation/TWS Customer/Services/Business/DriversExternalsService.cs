

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class DriversExternalsService : IDriversExternalsService {
    private readonly DriversExternalsDepot DriversExternals;

    public DriversExternalsService(DriversExternalsDepot driversExternals) {
        DriversExternals = driversExternals;
    }

    public async Task<SetViewOut<DriverExternal>> View(SetViewOptions<DriverExternal> Options) {
        return await DriversExternals.View(Options);
    }
}
