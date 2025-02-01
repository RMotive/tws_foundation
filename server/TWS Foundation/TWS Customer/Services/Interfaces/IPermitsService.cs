using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Security.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IPermitsService {
    Task<SetViewOut<Permit>> View(SetViewOptions<Permit> Options);

}
