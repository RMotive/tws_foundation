using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class SituationsService : ISituationsService {
    private readonly SituationsDepot Situations;

    public SituationsService(SituationsDepot situations) {
        Situations = situations;
    }

    public async Task<SetViewOut<Situation>> View(SetViewOptions<Situation> options) {
        return await Situations.View(options);
    }

}
