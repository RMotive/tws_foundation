using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

using TWS_Security.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IDriversService {
    Task<SetViewOut<Driver>> View(SetViewOptions<Driver> Options);
    Task<SetBatchOut<Driver>> Create(Driver[] Driver);
    Task<RecordUpdateOut<Driver>> Update(Driver Driver);
    Task<Driver> Delete(Driver Driver);

}
