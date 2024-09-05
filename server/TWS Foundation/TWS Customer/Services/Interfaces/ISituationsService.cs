using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ISituationsService {

    Task<SetViewOut<Situation>> View(SetViewOptions options);
    Task<Situation> Create(Situation situation);

}
