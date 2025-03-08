

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class DriversService : IDriversService {
    private readonly DriversDepot Drivers;

    public DriversService(DriversDepot drivers) {
        Drivers = drivers;
    }

    public async Task<SetViewOut<Driver>> View(SetViewOptions<Driver> Options) {
        static IQueryable<Driver> include(IQueryable<Driver> query) {
            return query
            .Include(t => t.Employee)
                .ThenInclude(i => i!.Identification);
        }
        return await Drivers.View(Options, include);
    }
}
