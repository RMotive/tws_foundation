using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksService {
    Task<SetViewOut<Truck>> View(SetViewOptions<Truck> options);
    Task<DatabasesTransactionOut<Truck>> Create(Truck[] trucks);
    Task<RecordUpdateOut<Truck>> Update(Truck Truck, bool updatePivot);


}
