using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities;

namespace TWS_Customer.Services.Interfaces;
public interface ITrailersExternalsService {
    Task<SetViewOut<TrailerExternal>> View(SetViewOptions<TrailerExternal> Options);
}
