using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksExternalsService {
    Task<SetViewOut<TruckExternal>> View(SetViewOptions Options);
    Task<DatabasesTransactionOut<TruckExternal>> Create(TruckExternal[] trucks);
    Task<RecordUpdateOut<TruckExternal>> Update(TruckExternal Truck);
}
