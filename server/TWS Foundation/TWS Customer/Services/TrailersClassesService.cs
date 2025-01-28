using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrailersClassesService : ITrailersClassesService {
    private readonly TrailerClassesDepot TrailersClasses;

    public TrailersClassesService(TrailerClassesDepot trailersClasses) {
        TrailersClasses = trailersClasses;
    }

    private IQueryable<TrailerClass> Include(IQueryable<TrailerClass> query) {
        return query.Select(t => new TrailerClass {
            Id = t.Id,
            Timestamp = t.Timestamp,
            Name = t.Name,
            Description = t.Description,
        });
    }

    public async Task<SetViewOut<TrailerClass>> View(SetViewOptions<TrailerClass> Options) {
        return await TrailersClasses.View(Options, Include);
    }
}
