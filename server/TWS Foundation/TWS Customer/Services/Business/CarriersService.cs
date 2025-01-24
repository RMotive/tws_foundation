

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class CarriersService : ICarriersService {
    private readonly CarriersDepot Carriers;

    public CarriersService(CarriersDepot carriers) {
        Carriers = carriers;
    }

    IQueryable<Carrier> Include(IQueryable<Carrier> query) {
        return query
            .Include(t => t.AddressNavigation)
            .Include(t => t.ApproachNavigation)
            .Include(t => t.UsdotNavigation)
            .Include(t => t.StatusNavigation);
    }

    public async Task<SetViewOut<Carrier>> View(SetViewOptions<Carrier> Options) {
        return await Carriers.View(Options, Include);
    }

    public async Task<Carrier> Create(Carrier carrier) {
        return await Carriers.Create(carrier);
    }
}
