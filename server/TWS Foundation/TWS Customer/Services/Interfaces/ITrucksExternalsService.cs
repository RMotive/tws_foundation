using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksExternalsService {
    Task<SetViewOut<TruckExternal>> View(SetViewOptions<TruckExternal> Options);
    Task<SetBatchOut<TruckExternal>> Create(TruckExternal[] trucks);
    Task<EntityUpdateOut<TruckExternal>> Update(TruckExternal Truck);
}
