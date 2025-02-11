﻿

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class TrailersExternalsService : ITrailersExternalsService {
    private readonly TrailersExternalsDepot TrailersExternals;

    public TrailersExternalsService(TrailersExternalsDepot trailersExternals) {
        TrailersExternals = trailersExternals;
    }

    public async Task<SetViewOut<TrailerExternal>> View(SetViewOptions<TrailerExternal> Options) {
        static IQueryable<TrailerExternal> include(IQueryable<TrailerExternal> query) {
            return query
            .Include(t => t.TrailerCommonNavigation)
            .Select(p => new TrailerExternal() {
                Id = p.Id,
                Status = p.Status,
                Common = p.Common,
                UsaPlate = p.UsaPlate,
                MxPlate = p.MxPlate,
                Carrier = p.Carrier,
                TrailerCommonNavigation = p.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                    Id = p.TrailerCommonNavigation.Id,
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
        return await TrailersExternals.View(Options, include);
    }
}
