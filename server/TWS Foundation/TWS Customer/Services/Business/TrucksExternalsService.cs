

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class TrucksExternalsService : ITrucksExternalsService {
    private readonly TrucksExternalsDepot TrucksExternals;

    public TrucksExternalsService(TrucksExternalsDepot trucksExternals) {
        TrucksExternals = trucksExternals;
    }

    private IQueryable<TruckExternal> Include(IQueryable<TruckExternal> query) {
        return query
            .Include(t => t.Common)
                .ThenInclude(t => t!.Situation)

            .Include(t => t.Common)
                .ThenInclude(t => t!.Location)
                    .ThenInclude(t => t!.Address);
    }

    public async Task<SetViewOut<TruckExternal>> View(SetViewOptions<TruckExternal> Options) {
        return await TrucksExternals.View(Options, Include);
    }

    public async Task<SetBatchOut<TruckExternal>> Create(TruckExternal[] trucks) {
        return await TrucksExternals.Create(trucks);
    }

    public async Task<EntityUpdateOut<TruckExternal>> Update(TruckExternal Truck) {
        return await TrucksExternals.Update(Truck, Include);
    }
}
