

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class CarriersService : ICarriersService {
    private readonly CarriersDepot Carriers;

    public CarriersService(CarriersDepot carriers) {
        Carriers = carriers;
    }

    IQueryable<Carrier> Include(IQueryable<Carrier> query) {
        return query
            .Include(t => t.Address)
            .Include(t => t.Approach)
            .Include(t => t.USDOT)
            .Include(t => t.Status);
    }

    public async Task<SetViewOut<Carrier>> View(SetViewOptions<Carrier> Options) {
        return await Carriers.View(Options, Include);
    }

    public async Task<Carrier> Create(Carrier carrier) {
        return await Carriers.Create(carrier);
    }
}
