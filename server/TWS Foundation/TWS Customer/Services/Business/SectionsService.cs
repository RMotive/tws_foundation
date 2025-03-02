

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class SectionsService : ISectionsService {
    private readonly SectionsDepot Sections;

    public SectionsService(SectionsDepot sections) {
        Sections = sections;
    }

    public async Task<SetViewOut<Section>> View(SetViewOptions<Section> Options) {
        return await Sections.View(Options);
    }
}
