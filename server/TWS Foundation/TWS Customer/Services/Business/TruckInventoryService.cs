using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Trucks;

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
    private readonly TruckInventory TruckInventory;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Solutions"></param>
    public TruckInventoryService(TruckInventory TrucksInventories) {
        TruckInventory = TrucksInventories;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    public async Task<SetViewOut<TruckEntry>> View(SetViewOptions<TruckEntry> Options) {

        static IQueryable<TruckEntry> include(IQueryable<TruckEntry> query) {
            return query
            .Include(t => t.Section)
            .Include(t => t.Truck)
                .ThenInclude(t => t.Internal)
                    .ThenInclude(i => i!.Plates);
        }

        return await TruckInventory.View(Options, include);
    }
}
