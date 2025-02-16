using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksService {
    Task<SetViewOut<Truck>> View(SetViewOptions<Truck> options);
    Task<SetBatchOut<Truck>> Create(Truck[] trucks);
    Task<RecordUpdateOut<Truck>> Update(Truck Truck);


}
