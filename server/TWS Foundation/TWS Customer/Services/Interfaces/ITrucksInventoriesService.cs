using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities.Trucks;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksInventoriesService {

    Task<SetViewOut<TruckEntry>> View(SetViewOptions<TruckEntry> options);

}
