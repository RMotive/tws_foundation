using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
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
                .ThenInclude(t => t!.Location)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.Common)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.Carrier)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.Plates)

             .Include(t => t.TruckExternalNavigation)
                .ThenInclude(t => t!.TruckCommonNavigation);
        }

        return await TrucksInventoriesDepot.View(Options, include);
    }
}
