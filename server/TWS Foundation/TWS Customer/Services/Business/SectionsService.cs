

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

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
        static IQueryable<Section> include(IQueryable<Section> query) {
            return query
            .Include(t => t.Location);
        }
        return await Sections.View(Options, include);
    }
}
