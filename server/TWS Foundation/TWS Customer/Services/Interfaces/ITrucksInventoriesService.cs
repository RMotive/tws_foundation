using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

using TWS_Security.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksInventoriesService {

    Task<SetViewOut<TruckInventory>> View(SetViewOptions<TruckInventory> options);

}
