using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IDriversExternalsService {
    Task<SetViewOut<DriverExternal>> View(SetViewOptions<DriverExternal> Options);
    Task<SetBatchOut<DriverExternal>> Create(DriverExternal[] Driver);
    Task<RecordUpdateOut<DriverExternal>> Update(DriverExternal Driver);
}
