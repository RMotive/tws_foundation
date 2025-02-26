using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class TrucksService : ITrucksService {
    private readonly TruckDepot Trucks;

    public TrucksService(TruckDepot Trucks) {
        this.Trucks = Trucks;
    }


    private IQueryable<Truck> Include(IQueryable<Truck> query) {
        return query
        .Include(t => t.Insurance)
        .Include(t => t.Model)
        .Include(t => t.Maintenance)
        .Include(t => t.Common)
            .ThenInclude(t => t.Status)
        .Include(t => t.SCT)

        .Include(t => t.Common)
            .ThenInclude(c => c.Situation)

        .Include(t => t.Carrier)
            .ThenInclude(c => c.Address)
        .Include(t => t.Carrier)
            .ThenInclude(c => c.Approach)
        .Include(t => t.Carrier)
            .ThenInclude(c => c.USDOT);
    }
    public async Task<SetViewOut<Truck>> View(SetViewOptions<Truck> options) {
        return await Trucks.View(options, Include);
    }

    public async Task<SetBatchOut<Truck>> Create(Truck[] trucks) {
        return await Trucks.Create(trucks);
    }
    public async Task<EntityUpdateOut<Truck>> Update(Truck Truck) {
        return await Trucks.Update(Truck, Include);
    }
}
