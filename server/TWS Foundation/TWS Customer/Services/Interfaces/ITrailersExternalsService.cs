using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Customer.Services.Interfaces;
public interface ITrailersExternalsService {
    Task<SetViewOut<TrailerExternal>> View(SetViewOptions<TrailerExternal> Options);
}
