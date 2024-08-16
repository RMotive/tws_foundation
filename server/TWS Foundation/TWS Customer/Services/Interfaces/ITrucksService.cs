using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using TWS_Business.Sets;

using TWS_Customer.Services.Records;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksService {
    Task<SetViewOut<Truck>> View(SetViewOptions options);

    Task<SourceTransactionOut<Truck>> Create(Truck[] trucks);
}
