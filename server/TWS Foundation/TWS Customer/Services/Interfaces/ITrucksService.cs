using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksService {
    Task<SetViewOut<Truck>> View(SetViewOptions options);
    Task<DatabasesTransactionOut<Truck>> Create(Truck[] trucks);
    Task<RecordUpdateOut<Truck>> Update(Truck Truck, bool updatePivot);


}
