using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrailersTypesService : ITrailersTypesService {
    private readonly TrailersTypesDepot TrailersTypes;

    public TrailersTypesService(TrailersTypesDepot trailersTypes) {
        TrailersTypes = trailersTypes;
    }

    private IQueryable<TrailerType> Include(IQueryable<TrailerType> query) {
        return query
        .Include(t => t.TrailerClassNavigation).Select(t => new TrailerType {
            Id = t.Id,
            Timestamp = t.Timestamp,
            Status = t.Status,
            Size = t.Size,
            TrailerClass = t.TrailerClass,
            TrailerClassNavigation = t.TrailerClassNavigation == null? null : new TrailerClass() {
                Id = t.TrailerClassNavigation.Id,
                Timestamp = t.TrailerClassNavigation.Timestamp,    
                Name = t.TrailerClassNavigation.Name,
                Description = t.TrailerClassNavigation.Description,
            }
        });
    }

    public async Task<SetViewOut<TrailerType>> View(SetViewOptions<TrailerType> Options) {
        return await TrailersTypes.View(Options, Include);
    }
}
