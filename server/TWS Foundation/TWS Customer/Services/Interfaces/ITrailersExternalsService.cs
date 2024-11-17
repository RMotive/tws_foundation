using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ITrailersExternalsService {
    Task<SetViewOut<TrailerExternal>> View(SetViewOptions<TrailerExternal> Options);
    Task<SetBatchOut<TrailerExternal>> Create(TrailerExternal[] TrailersExternal);
    Task<RecordUpdateOut<TrailerExternal>> Update(TrailerExternal TrailerExternal);
}
