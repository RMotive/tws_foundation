

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrailersExternalsService : ITrailersExternalsService {
    private readonly TrailersExternalsDepot TrailersExternals;

    public TrailersExternalsService(TrailersExternalsDepot trailersExternals) {
        TrailersExternals = trailersExternals;
    }

    private IQueryable<TrailerExternal> Include(IQueryable<TrailerExternal> query) {
        return query
            .Include(t => t.TrailerCommonNavigation)
                .ThenInclude(t => t!.SituationNavigation)
            .Include(t => t.TrailerCommonNavigation)
                .ThenInclude(t => t!.TrailerTypeNavigation)
            .Include(t => t.TrailerCommonNavigation)
                .ThenInclude(t => t!.LocationNavigation)
                    .ThenInclude(t => t!.AddressNavigation)

            .Include(t => t.TrailerCommonNavigation)
                .ThenInclude(t => t!.TrailerTypeNavigation)
                    .ThenInclude(t => t!.TrailerClassNavigation)

            .Select(p => new TrailerExternal() {
                Id = p.Id,
                Timestamp = p.Timestamp,
                Status = p.Status,
                Common = p.Common,
                UsaPlate = p.UsaPlate,
                MxPlate = p.MxPlate,
                Carrier = p.Carrier,
                TrailerCommonNavigation = p.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                    Id = p.TrailerCommonNavigation.Id,
                    Timestamp = p.TrailerCommonNavigation.Timestamp,
                    Status = p.TrailerCommonNavigation.Status,
                    Economic = p.TrailerCommonNavigation.Economic,
                    Type = p.TrailerCommonNavigation.Type,
                    Situation = p.TrailerCommonNavigation.Situation,
                    Location = p.TrailerCommonNavigation.Location,
                    SituationNavigation = p.TrailerCommonNavigation.SituationNavigation,
                    TrailerTypeNavigation = p.TrailerCommonNavigation.TrailerTypeNavigation,
                    LocationNavigation = p.TrailerCommonNavigation.LocationNavigation
                },
            });

    }

    public async Task<SetViewOut<TrailerExternal>> View(SetViewOptions<TrailerExternal> Options) {
        return await TrailersExternals.View(Options, Include);
    }
    public async Task<SetBatchOut<TrailerExternal>> Create(TrailerExternal[] Trailers) {
        return await TrailersExternals.Create(Trailers);
    }
    public async Task<RecordUpdateOut<TrailerExternal>> Update(TrailerExternal Trailer) {
        return await TrailersExternals.Update(Trailer, Include);
    }
}
