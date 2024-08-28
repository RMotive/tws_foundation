using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ITrailersExternalsService {
    Task<SetViewOut<TrailerExternal>> View(SetViewOptions Options);
}
