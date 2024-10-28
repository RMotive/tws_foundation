using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;
using TWS_Customer.Services.Records;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Customer.Services;
/// <summary>
/// 
/// </summary>
public class TruckInventoryService
    : ITrucksInventoriesService {
    /// <summary>
    /// 
    /// </summary>
    private readonly TrucksInventoriesDepot TrucksInventoriesDepot;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Solutions"></param>
    public TruckInventoryService(TrucksInventoriesDepot TrucksInventories) {
        TrucksInventoriesDepot = TrucksInventories;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    public async Task<SetViewOut<TruckInventory>> View(SetViewOptions<TruckInventory> Options) {

        static IQueryable<TruckInventory> include(IQueryable<TruckInventory> query) {
            return query
            .Include(t => t.SectionNavigation)
                .ThenInclude(t => t!.LocationNavigation)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.TruckCommonNavigation)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.Plates)

             .Include(t => t.TruckExternalNavigation)
                .ThenInclude(t => t!.TruckCommonNavigation);
        }

        return await TrucksInventoriesDepot.View(Options, include);
    }
}
